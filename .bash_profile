# Suppress the warning about zsh on mac
export BASH_SILENCE_DEPRECATION_WARNING=1
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"
