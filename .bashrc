
if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi

export PATH="$HOME/.local/bin:$PATH"
[ ! -f $HOME/.bash_functions/bash-prompt.sh ] || . $HOME/.bash_functions/bash-prompt.sh
[ ! -f $HOME/.git-prompt.sh ] || . $HOME/.git-prompt.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

alias ec='emacsclient --tty --create-frame --alternate-editor=""'
