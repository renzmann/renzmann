#!/usr/bin/env bash
install-mill() {
  if [[ -z $1 ]]; then
    local version="0.10.0"
  else
    local version=$1
  fi

  curl -L https://github.com/com-lihaoyi/mill/releases/download/$version/$version \
    > $HOME/.local/bin/mill \
    && chmod u+x $HOME/.local/bin/mill
}
