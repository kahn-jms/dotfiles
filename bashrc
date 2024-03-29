# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# If not running interactively, don't do anything (alternative method)
#[ -z "$PS1" ] && return

# Don't escape $ in evnironment variables when tab completing
shopt -s direxpand

## History control, taken from:
## http://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups:ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# Sync history between terminals
#PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Set the history size
export HISTSIZE=5000
# And set the history file size
export HISTFILESIZE=10000


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
  PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\]\[\033[01;34m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[00;35m\]\$\[\033[00m\] '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  #eval "`dircolors -b`"
  alias ls='ls --color=auto'
  #alias dir='ls --color=auto --format=vertical'
  #alias vdir='ls --color=auto --format=long'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#alias ssh='ssh -X'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#### Misc Customisations ####

# Aliases for mounting tablet
#alias android-connect='mtpfs -o allow_other /media/Nexus7'
#alias android-disconnect='fusermount -u /media/Nexus7'

# Set path for go programming language. Using for 'drive' app.
export GOPATH=$HOME/go
if [ -d $GOPATH ] ; then
	export PATH=$GOPATH:$GOPATH/bin:$PATH
fi

# Set vim as default shell editor
export VISUAL=vim
export EDITOR="$VISUAL"
# And to open with a server
alias vim='vim --servername vim'

## Texlive settings
# Add Texlive in dir to path
## 2019
#export PATH=$HOME/.local/texlive/2019/bin/x86_64-linux:$PATH
## And the man pages
#export MANPATH=$HOME/.local/texlive/2019/texmf-dist/doc/man:$MANPATH
# 2020
#export PATH=$HOME/.local/texlive/2020/bin/x86_64-linux:$PATH
## And the man pages
#export MANPATH=$HOME/.local/texlive/2020/texmf-dist/doc/man:$MANPATH
# 2021
# Add Texlive in dir to path
export PATH=$HOME/.local/texlive/2022/bin/x86_64-linux:$PATH
# And the man pages
export MANPATH=$HOME/.local/texlive/2022/texmf-dist/doc/man:$MANPATH

# Set texmfhome to a cleaner place (if it exists)
if [ -d ~/.local/texmf ] ; then
    export TEXMFHOME=~/.local/texmf
fi

## Add user local bin to path for userspace installed programs
if [ -d ~/.local/bin ] ; then
  export PATH=$HOME/.local/bin:$PATH
fi

# Kuhrios
if [ -d /srv/data/jkahn/output ] ; then
		export WORK=/srv/data/jkahn/output
fi

## A locally installed python libs, need this for mypy in vim
export MYPYPATH=$(python3 -c "import sys; print(':'.join([i for i in sys.path if 'home' in i]))")

## Tell tmux to make sessions in home directory so they're persistent across hosts with shared filesystems
export TMUX_TMPDIR=${HOME}/.tmux

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jkahn/.local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
		eval "$__conda_setup"
else
		if [ -f "/home/jkahn/.local/anaconda3/etc/profile.d/conda.sh" ]; then
				. "/home/jkahn/.local/anaconda3/etc/profile.d/conda.sh"
		else
				export PATH="/home/jkahn/.local/anaconda3/bin:$PATH"
		fi
fi
unset __conda_setup
# <<< conda initialize <<<

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . "/usr/share/bash-completion/bash_completion"
  elif [ -f /etc/bash_completion ]; then
    . "/etc/bash_completion"
  fi
fi

# Install Ruby Gems to ~/.gems
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.gems/bin:$PATH"
