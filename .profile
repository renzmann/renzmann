[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -d "$HOME/.jabba" ] && source "$HOME/.jabba/jabba.sh"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/opt/miniconda3/bin"
