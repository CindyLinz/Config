# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US:en

if [ -e /lib/emscripten ]; then
    export PATH=/lib/emscripten:$PATH
fi
if [ -e /opt/emscripten-llvm/bin ]; then
    export PATH=/opt/emscripten-llvm/bin:$PATH
fi
if [ -e ~/.cabal/bin ]; then
    export PATH=~/.cabal/bin:$PATH
fi
if [ -e ~/.local/bin ]; then
    export PATH=~/.local/bin:$PATH
fi
if [ -e ~/bin ]; then
    export PATH=~/bin:$PATH
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [[ -z "$color_prompt" && -n "$force_color_prompt" ]]; then
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
    PS1='\[\033[1;31m\D{%Y.%-m.%-d}-\t \033[1;32m\]\u\[\033[1;33m\]@\[\033[1;34m\]\h:\[\033[1;36m\]\w\[\033[1;35m\]\$\[\033[0;37m\]\[\033[m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\D{%Y.%-m.%-d}-\t \u@\h:\w\$ '
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias :q='exit'
alias :q!='exit'
alias :wq='exit'
alias :wq!='exit'
alias :wqa='exit'
alias :qa='exit'
alias :qa!='exit'

if [ -x /usr/bin/most ]; then
    export PAGER=/usr/bin/most
fi

if [ -x /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

if [ -x /usr/bin/firefox ]; then
    export BROWSER=/usr/bin/firefox
elif [ -x /usr/bin/chromium ]; then
    export BROWSER=/usr/bin/chromium
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Android PATH
if [ -e ~/practice/android/android-sdk-linux ]; then
    export PATH=~/practice/android/android-sdk-linux/platform-tools:~/practice/android/android-sdk-linux/tools:$PATH
fi

# stolen from c9s
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

if [ -e ~/perl5/perlbrew/etc/bashrc ]; then
    source ~/perl5/perlbrew/etc/bashrc
    #perlbrew use $(perlbrew list | tac - | head -n1 | sed 's/*//')
fi

if [ -e ~/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

if [ -e /usr/bin/meh ]; then
    complete -o plusdirs -f -X '!*.@(jpg|jpeg|png|bmp|gif|webp|pdf|svg|JPG|JPEG|PNG|BMP|GIF|WEBP|PDF|SVG)' meh
fi
if [[ -e /usr/bin/dhcpcd && -e /usr/bin/ip ]]; then
    function list_ip_link(){ # $2
        COMPREPLY=()
        IFS=$'\n'
        for line in $(/usr/bin/ip link); do
            pat='^[0-9]+: ([^:]+):'
            if [[ $line =~ $pat ]]; then
                dev=${BASH_REMATCH[1]}
                pat="^$2"
                if [[ $dev =~ $pat ]]; then
                    COMPREPLY+=($dev)
                fi
            fi
        done
    }
    complete -F list_ip_link dhcpcd
fi

stty stop ''
stty start ''
stty -ixon
stty -ixoff
