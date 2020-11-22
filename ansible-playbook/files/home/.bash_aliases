#!/usr/bin/env bash
# ^ Enables ShellCheck

# -G is enable color on OSX, but hide groups on Linux
if [[ $OSTYPE =~ linux ]]; then
  alias ll='ls -clashB --color=auto'
else
  alias ll='ls -clashBG'
fi

if hash hub 2>/dev/null; then
  eval "$(hub alias -s)"
fi

alias watch='watch --color'

alias now='date "+%Y%m%d_%H%M%S"'

if hash docker-compose 2>/dev/null; then
  alias fig='docker-compose'
fi

if hash vagrant 2>/dev/null; then
  alias v='vagrant'
fi

# Put color in tree
alias tree='tree -C'

alias ssh='ssh -o VisualHostKey=yes'

# workaround to use vim as the crontab editor
# (http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place)
alias crontab="VIM_CRONTAB=true crontab"

# Let's give this dev journal a try
alias journal='cd ~/code/journal && vim `date +"%Y-%m-%d"`.md'

# Requires AnyBar and hub
# Checks the ci-status on GitHub and changes the dot color accordingly
# FIXME this is probably a good candidate for a function
alias ciw='while true; do
  icon="question"
  ci_status="$(hub ci-status)"

  case "$ci_status" in
  "pending")
    icon="orange"
    ;;
  "success")
    icon="green"
    ;;
  "failure")
    icon="red"
    ;;
  *)
    icon="question"
    ;;
  esac

  echo -n "${icon}" | nc -4u -w0 localhost 1738

  if [ $icon == "green" ] || [ $icon == "red" ]; then
    break
  fi

  sleep 5;
done &'

# tree in a node project outputs a lot of cruft
alias tnode='tree -I node_modules'

# FIXME Linux only, OSX uses pbcopy
if hash xclip 2>/dev/null; then
  alias cb='xclip -sel clip'
fi

# this is easier to type
if hash git 2>/dev/null; then
  alias gi=git
fi

if hash tree 2>/dev/null; then
  alias t="tree -aI '.git|node_modules|*~|*.swp'"
fi

# generate passwords, args: [-y] (symbols) [length]
# double quoting the variables breaks the function when called without
# arguments
# shellcheck disable=SC2086
pwg() { pwgen -cs $1 ${2:-32} 64 | tr '\n' ' ' | cut -f "$(shuf -i 1-32 -n 1)" -d ' '; }

# Enable color output, don't page if only one screen, don't clear screen
alias less='less -RFX'
