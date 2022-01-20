#!/usr/bin/env bash

# Section: bash
funced () {
  local name=$1
  linenum=$(grep -En "^$name \(" $HOME/.func.sh | awk -F ':' '{ print $1 }')
  vim +$linenum "$HOME/.func.sh" && source $HOME/.func.sh
}

ll () { ls -lah; }
la () { ls -A; }
l  () { ls -CF; }

# Section: python
so () { source .venv/bin/activate; }

new-venv () {
  python3 -m venv .venv
  so
  python3 -m pip install --upgrade pip
  python3 -m pip install wheel
}

# Section: vim
vim-add () {
  local arg="$1"
  local branch="$2"
  local IFS='/'
  set -- $arg
  local author="$1"
  local plugin="$2"
  if [ -z $branch ]; then local branch="master"; fi
  cd $HOME
  git subtree add -P .vim/pack/$author/start/$plugin git@github.com:$arg $branch --squash
  cd -
}

vim-rm () {
  local IFS='/'
  set -- $1
  local author=$1
  local plugin=$2
  rm -rf $HOME/.vim/pack/$author/start/$plugin
}

