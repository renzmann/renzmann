#!/usr/bin/env bash

funced () {
  local name=$1
  linenum=$(grep -En "^$name \(" $HOME/.func.sh | awk -F ':' '{ print $1 }')
  vim +$linenum "$HOME/.func.sh"
}

ll () { ls -lah; }
la () { ls -A; }
l  () { ls -CF; }

this-fails () {
  echo $1
  local name=$1
  linenum=$(grep -En "^$name \(" $HOME/.func.sh | awk -F ':' '{ print $1 }')
  echo $linenum
}

so () { source .venv/bin/activate; }

new-venv () {
  python3 -m venv .venv
  so
  python3 -m pip install --upgrade pip
  python3 -m pip install wheel
}

