export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin"

[ ! -z $GOPATH ] || export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

[ -d "$HOME/.cargo" ] && source "$HOME/.cargo/env"

if [ -d "$HOME/.coursier" ]; then
	export PATH="$HOME/.coursier:$PATH"
	export PATH="$HOME/.local/share/coursier/bin:$PATH"
fi

[ -d "$HOME/Applications/kitty.app" ] && export PATH="$PATH:$HOME/Applications/kitty.app/Contents/MacOS/"
[ -d "$HOME/Applications/Emacs.app" ] && export PATH="$PATH:$HOME/Applications/Emacs.app/Contents/MacOS/bin"
[ -d "$HOME/Applications/CMake.app" ] && export PATH="$PATH:$HOME/Applications/CMake.app/Contents/bin"
[ -d "$HOME/Library/Application Support/Coursier" ] && export PATH=$PATH:"$HOME/Library/Application Support/Coursier/bin"
[ -d "$HOME/.jabba" ] && source "$HOME/.jabba/jabba.sh"
[ -d "$HOME/opt/miniconda3" ] && export PATH="$PATH:$HOME/opt/miniconda3/bin"
[ -d "$HOME/.conda/envs/robbmann/" ] && export PATH="$HOME/.conda/envs/robbmann/bin:$PATH"
export PATH="$PATH:$HOME/.emacs.d/bin"
