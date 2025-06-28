# QOL aliases
alias gts='gt sync; git submodule update --recursive;'
alias rm='rm -i'

export EDITOR="/usr/bin/vim"


### CUSTOM BASH PROMPT
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
	parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	}
	
	COLOR_RED='\033[01;31m'
	COLOR_YELLOW='\033[01;33m'
	COLOR_GREEN='\033[01;32m'
	COLOR_CYAN='\033[01;36m'

	function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! (($git_status =~ "working directory clean") || ($git_status =~ "working tree clean")) ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_CYAN
  fi
}

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
##### WHAT YOU WANT TO DISABLE FOR WARP - BELOW

PROMPT_COMMAND="__prompt_command; ${PROMPT_COMMAND}"

__prompt_command(){
	local exit="$?"
	PS1=''

	if [ "$exit" -eq 0 ]
	then
		PS1=$'\n\[\033[01;35m\]\u@\h \[\033[01;34m\]\w\[$(git_color)\]$(parse_git_branch)\n\['$COLOR_CYAN'\]❯\[\033[00m\] '

	else
		PS1=$'\n\[\033[01;35m\]\u@\h \[\033[01;34m\]\w\[$(git_color)\]$(parse_git_branch)\n\['$COLOR_RED'\]❯\[\033[00m\] '

	fi
}

##### WHAT YOU WANT TO DISABLE FOR WARP - ABOVE
fi


else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

umask 0077

#makes ls directory colors blue, executables red, symlinks cyan
LS_COLORS=$LS_COLORS:'di=1;34' ; export LS_COLORS
LS_COLORS=$LS_COLORS:'ex=0;31' ; export LS_COLORS
LS_COLORS=$LS_COLORS:'ln=0;36' ; export LS_COLORS
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
