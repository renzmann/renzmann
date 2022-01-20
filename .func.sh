#!/usr/bin/env bash

funced () {
  local name=$1
  linenum=$(grep -En "^$name \(" $HOME/.func.sh | awk -F ':' '{ print $1 }')
  vim +$linenum "$HOME/.func.sh" && source $HOME/.func.sh
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
  local author=$(echo $1 | awk -F '/' '{ print $1 }')
  local plugin=$(echo $1 | awk -F '/' '{ print $2 }')
  local branch=$2
  if [ -z $branch ]; then local branch="master"; fi
  cd $HOME
  git subtree add -P .vim/pack/$author/start/$plugin git@github.com:$1 $branch --squash
  cd -
}

