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
[ -d "$HOME/miniconda3" ] && export PATH="$PATH:$HOME/miniconda3/bin"
[ -d "$HOME/.conda/envs/robbmann/" ] && export PATH="$PATH:$HOME/.conda/envs/robbmann/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"

case $- in
  *i*)
    # Interactive session. Try switching to bash.
    if [ -z "$BASH" ]; then # do nothing if running under bash already
      bash=$(command -v bash)
      if [ -x "$bash" ]; then
        export SHELL="$bash"
        exec "$bash"
      fi
    fi
esac

alias ec='emacsclient -nw -a vim'

case "$TERM" in
    dumb|emacs*|eterm*)
        # M-x shell from emacs can't handle interactive output
        alias m='cat'
        alias less='cat'
        alias more='cat'
        export PAGER=cat
        export EDITOR=ec
        ;;
    eat-truecolor)
        # Most programs don't know how to handle "eat-truecolor"
        export TERM=xterm-256color
        ;;
    *)
        alias m='more'
        alias l='less'
        export EDITOR=vim
        ;;
esac
