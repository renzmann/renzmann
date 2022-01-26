#!/bin/sh

# https://get-coursier.io/docs/cli-installation
install-cs() {
  curl -fLo cs https://git.io/coursier-cli-"$(uname | tr LD ld)"
  chmod u+x cs
  ./cs install cs
  rm ./cs
}
