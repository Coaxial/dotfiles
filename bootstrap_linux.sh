#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

printf 'Setting up SSH key...\n'
./lib/scripts/setup_ssh.sh

printf 'Installing git...\n'
./lib/scripts/install_git.sh

printf 'Configuring git...\n'
./lib/scripts/setup_git.sh
./lib/scripts/change_repo_origin.sh

printf 'Installing fonts...\n'
./lib/scripts/dl_fonts.sh Linux

printf 'Linking dotfiles...\n'
./lib/scripts/symlink_dotfiles.sh

printf 'Copying local overrides...\n'
./lib/scripts/cp_local.sh

printf 'Installing vim...\n'
./lib/scripts/vim.sh

printf 'Installing RVM + Ruby...\n'
./lib/scripts/rvm_install.sh

printf 'Installing NVM + node...\n'
./lib/scripts/install_nvm.sh

printf 'Enabling backups...\n'
./lib/scripts/backups.sh

printf 'Running postinstall script...\n'
./lib/scripts/post_install.sh
