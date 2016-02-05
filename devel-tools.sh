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

echo "Remove useless stuff."

