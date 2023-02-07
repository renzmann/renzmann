
if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi

export PATH="$HOME/.local/bin:$PATH"
[ ! -f $HOME/.bash_functions/bash-prompt.sh ] || . $HOME/.bash_functions/bash-prompt.sh