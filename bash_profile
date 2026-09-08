export CLICOLOR=1
export BASH_SILENCE_DEPRECATION_WARNING=1
export LSCOLORS=ExgxBxDxbxegedabagacad

#homebrew
export PATH=/opt/homebrew/bin:/usr/local/sbin:$PATH

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#load .bashrc
[ -r ~/.bashrc ] && source ~/.bashrc

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :
