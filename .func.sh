#!/usr/bin/env bash

funced () {
  local name=$1
  linenum=$(grep -En "^$name \(" $HOME/.func.sh | awk -F ':' '{ print $1 }')
  vim +$linenum "$HOME/.func.sh"
}

ll () { ls -lah; }
la () { ls -A; }
l  () { ls -CF; }

so () { source .venv/bin/activate; }

new-venv () {
  python3 -m venv .venv
  so
  python3 -m pip install --upgrade pip
  python3 -m pip install wheel
}

vim-add () {
  # Should get something like tpope/vim-sensible and then execute:
  # git subtree add -P .vim/pack/tpope/start/vim-sensible git@github.com:tpope/vim-sensible --squash
  ...
}
