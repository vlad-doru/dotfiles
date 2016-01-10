# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bindkey '^R' history-incremental-pattern-search-backward

# Add Golang to the path.
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

source ~/plugins/zsh-git-prompt/zshrc.sh
# an example prompt
PROMPT='%B%m%~%b$(git_super_status) %# '
