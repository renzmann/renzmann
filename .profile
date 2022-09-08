export PATH="/usr/local/bin:/usr/bin:/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"
[ ! -z $GOPATH ] || export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.coursier:$PATH"
export PATH=$PATH:"$HOME/Library/Application Support/Coursier/bin"
if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi
