#!/bin/sh
printf "==============================\n"
printf "Welcome to a notebook terminal\n"
printf "==============================\n"
printf "\n"
printf "Notes about this terminal:\n"
printf " * Runs separately from kernels so packages installed from here will most likely not be available at cell execution.\n"
printf " * Shares /home/jupyter with the notebooks so files created in /home/jupyter will show in the file hierarchy.\n"
printf "\n"

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

export PATH="$PATH:$HOME/.local/bin"
source $HOME/fancy-prompt.sh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/jupyter/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/jupyter/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/jupyter/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/jupyter/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/jupyter/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

conda activate keelback
