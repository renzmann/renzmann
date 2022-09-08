export PATH="/usr/local/bin:/usr/bin:/bin"
export PATH="$HOME/.local/bin:$PATH"

[ ! -z $GOPATH ] || export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

if [ -d "$HOME/.cargo" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
	source "$HOME/.cargo/env"
fi

if [ -d "$HOME/.coursier" ]; then
	export PATH="$HOME/.coursier:$PATH"
	export PATH="$HOME/.local/share/coursier/bin:$PATH"
fi

[ -d "$HOME/Applications/kitty.app" ] && export PATH="$PATH:$HOME/Applications/kitty.app/Contents/MacOS/"
[ -d "$HOME/Library/Application Support/Coursier" ] && export PATH=$PATH:"$HOME/Library/Application Support/Coursier/bin"
[ -d "$HOME/.jabba" ] && source "$HOME/.jabba/jabba.sh"
[ -d "$HOME/opt/miniconda3" ] && export PATH="$PATH:$HOME/opt/miniconda3/bin"
