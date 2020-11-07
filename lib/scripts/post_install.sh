#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

printf "Done setting everything up, manual steps are required:\n"
printf "If backups were enabled:\n"
printf "  * Fetch borg key from password manager and paste it in ~/.config/borgmatic/passphrase\n"
printf "  * Install borgmatic as per https://torsion.org/borgmatic/docs/how-to/set-up-backups/#other-ways-to-install\n"
printf "  * Configure SSH in ~/.ssh/config\n"
printf "Exiting.\n"
