# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#test

#add warning to remove function
alias rm='rm -i'

#set vim as default editor
export EDITOR="/usr/bin/vim"

#enable python3 on student machines
export PATH=/escnfs/home/pbui/pub/pkgsrc/bin:$PATH

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#tell you holidays at login :)
if [[ $- == *i* ]]
then
	~/.scripts/holidays.sh 2> /dev/null
fi


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
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
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	
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


#\u2192 = →
#\[\033[00m\] '
#	PS1=$'\[\033[01;32m\]\u2192  \[\033[01;35m\]\h \[\033[01;34m\]\w\[\033[01;36m\]$(parse_git_branch) \[\033[00m\]'
#PS1=$'\[\033[01;32m\]\u2192  \[\033[01;35m\]\h \[\033[01;34m\]\w \[\033[01;36m\]($(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \[\033[00m\]'
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
