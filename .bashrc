# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

[ -z "$PS1" ] && return

export LC_ALL=zh_TW.UTF-8
export LANG=zh_TW.UTF-8

export EDITOR=vim
export PAGER=most

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If running interactively, then:

    # don't put duplicate lines in the history. See bash(1) for more options
    # export HISTCONTROL=ignoredups

    # enable color support of ls and also add handy aliases
	#eval `dircolors -b`
    #alias ls='ls -G'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    # some more ls aliases
    alias ls='ls --color=auto'
    #alias ll='ls -l'
    #alias la='ls -A'
    #alias l='ls -CF'

    # something with warning
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'

    # set a fancy prompt
    PS1='\[\033[1;32m\]\u\[\033[1;33m\]@\[\033[1;34m\]\h:\[\033[1;36m\]\w\[\033[1;35m\]\$\[\033[0;37m\] '

    # If this is an xterm set the title to user@host:dir
    #case $TERM in
    #xterm*)
    #    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    #    ;;
    #*)
    #    ;;
    #esac

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi

    PATH=~/.cabal/bin:$PATH

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi
