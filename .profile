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

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last
# PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Set the default editor to be vim
# shellcheck disable=SC2155
export EDITOR="$(which vim)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
