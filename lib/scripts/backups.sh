#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

read -r -p "Enable scheduled backups on this machine? [Y/n] " continue
continue=${continue:-"y"}

if [[ "$continue" != @(y|Y) ]]
then
  sudo cp root/etc/systemd/system/borgmatic.service /etc/systemd/system
  sudo cp root/etc/systemd/system/borgmatic.timer /etc/systemd/system
  sudo systemctl enable --now borgmatic.timer
  printf "Done enabling backups."
else
  printf "Skipping backups.\n"
fi
