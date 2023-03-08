export CLICOLOR=1
export BASH_SILENCE_DEPRECATION_WARNING=1
export LSCOLORS=ExgxBxDxbxegedabagacad

#homebrew
export PATH=/usr/local/sbin:$PATH

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#load .bashrc
[ -r ~/.bashrc ] && source ~/.bashrc

export PATH=/opt/homebrew/bin:$PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH=/usr/local/mysql/bin:$PATH
