#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../.."
declare -a dotfiles=(\
  .ansible.cfg \
  .asciinema/ \
  .bash_aliases \
  .bash_prompt \
  .bashrc \
  .config/nvim \
  .config/borgmatic \
  .gemrc \
  .ghc \
  .gitconfig \
  .gitignore_global \
  .gvimrc \
  .irssi \
  .maid/ \
  .path\
  .profile \
  .tmux.conf \
  .tmux/ \
  .vimrc 
)

for dotfile in "${dotfiles[@]}"
do
  if [ -e "$HOME/$dotfile" ]
  then
    printf "File %s already exist in ~, overwrite? [Y/n] " "$dotfile"
    read -r overwrite
    overwrite=${overwrite:-"y"}

    if [[ "$overwrite" != @(y|Y) ]]
    then
      continue
    fi

    rm -rf "${HOME:?}/$dotfile"
  fi

  ln -s "$DIR/$dotfile" "$HOME"
done
