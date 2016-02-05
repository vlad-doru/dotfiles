set -e

sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing versioning tools."  
sudo apt-get -y install git mercurial 
echo "Installing language tools."
sudo apt-get install -y golang cmake nodejs python-dev python-pip node npm
if [ ! -d "$HOME/go" ]; then
	mkdir $HOME/go
fi

echo "Installing development tools."
sudo apt-get -y install vim tmux zsh

echo "Confiugring TMUX"
cp ./.tmux.conf ~

echo "Configuring ZSH."
echo "Installing Powerline"
sudo pip install git+git://github.com/Lokaltog/powerline
if [ ! -d "$HOME/.fonts" ]; then
	wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
	mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
	fc-cache -vf ~/.fonts
	mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then 
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
cp ./.zpreztorc ~
cp ./.zshrc ~
chsh -s $(which zsh)
exit 1

echo "Configuring VIM."
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then 
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
cp ./.vimrc ~/
vim +PluginInstall +qall

echo "Configuring YouCompleteMe."
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer --gocode-completer --tern-completer
cd -

echo "Installing Various Libraries"
sudo npm install -g bower
sudo apt-get install -y python3 python3-dev python3-pip
sudo apt-get install -y python-numpy python3-numpy python-scipy python3-scipy python-pandas python3-pandas python-matplotlib python3-matplotlib
sudo apt-get install -y ipython3 ipython3-notebook

echo "Installing Latex"
sudo apt-get install -y texlive-full

echo "Installing Docker"
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
sudo apt-get update 
sudo apt-get purge -y lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get install -y apparmor linux-image-extra-$(uname -r)
sudo apt-get install -y docker-engine
sudo getent group docker || sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
docker run hello-world

echo "Installing R Language"
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update 
sudo sh -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""
sudo apt-get -y install libcurl4-gnutls-dev libxml2-dev libssl-dev
sudo sh -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""

echo "Installing Google Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable

echo "Installing JAVA."
sudo apt-get install -y default-jre default-jdk
sudo apt-get install -y python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

echo "Remove useless stuff."
sudo apt-get -y autoremove

