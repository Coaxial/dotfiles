#!/usr/bin/env bash
# ^ Enable SC

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last
# PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Set the default editor to be nvim if present, vim otherwise
# shellcheck disable=SC2155
if hash nvim 2>/dev/null; then
  export EDITOR="$(command -v nvim)"
else
  export EDITOR="$(command -v vim)"
fi

# Load RVM into a shell session *as a function*
# shellcheck disable=SC1090
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm

# set CapsLock to Esc
if hash setxkbpmap 2>/dev/null; then
  setxkbmap -option "caps:swapescape"
fi

export PATH="$HOME/.cargo/bin:$PATH"

# Put Go in path
export "PATH=:$PATH:/usr/local/go/bin:${HOME}/go/bin"

# See https://archive.fo/oQIdU or http://mywiki.wooledge.org/DotFiles for why
# this is that way.
if [ -n "$BASH"  ] && [ -r ~/.bashrc  ]; then
  # shellcheck disable=SC1090
  . "$HOME/.bashrc"
fi
