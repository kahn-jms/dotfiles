# ~/.bash_profile: executed by the command interpreter for bash login shells.
# This file means that .profile will not be read by bash(1).
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Load user ssh key if not already loaded (will prompt for password)
# Only works for shell login, not gnome, need to figure out why.
#if [ -z "$SSH_AUTH_SOCK" ] ; then
#  eval `ssh-agent -s`
#  ssh-add
#fi
