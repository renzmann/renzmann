#!/usr/bin/env bash

# In an interactive login shell, Bash first looks for the /etc/profile
# file. If found, Bash reads and executes it in the current shell. As
# a result, /etc/profile sets up the environment configuration for all
# users.  Similarly, Bash then checks if .bash_profile exists in the
# home directory. If it does, then Bash executes .bash_profile in the
# current shell. Bash then stops looking for other files such as
# .bash_login and .profile.  If Bash doesn’t find .bash_profile, then
# it looks for .bash_login and .profile, in that order, and executes
# the first readable file only.

# From the above, I set .bash_profile to just source this file, which
# in turn will make sure to grab any of the more common
# configurations, like $PATH, from the more general .profile

# Suppress the warning about zsh on mac
export BASH_SILENCE_DEPRECATION_WARNING=1
[ -f $HOME/.profile ] && source "$HOME/.profile"

# Source global definitions
if [[ -f /etc/bashrc ]]; then
    source /etc/bashrc
fi

# Things that need to be "sourced" instead of loaded on-demand
source $HOME/.git-prompt.sh
for file in $HOME/.bash_functions/*; do
    source $file
done

if [[ "$OSTYPE" =~ darwin ]]; then
    for x in $(echo "$HOME/Library/Python/*/bin"); do
	append_path $x
    done
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lah'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [[ "$OSTYPE" =~ darwin ]]; then
    alias ls='ls --color=yes'
    alias ll='ls -lah'
    alias grep='grep --color=yes'
    alias fgrep='fgrep --color=yes'
    alias egrep='egrep --color=yes'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Make <C-q> work in vim
[[ $- == *i* ]] && stty start undef
# Don't hang on ctrl-s https://unix.stackexchange.com/a/12108
[[ $- == *i* ]] && stty -ixon

# FIXME: these cause a big login time performance hit - any way to lazy-load them on demand?
# nvm setup bits
export NVM_DIR="$HOME/.nvm"
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

case "$TERM" in
    dumb|emacs*)
    ;;
    *)
    # REMINDME: This is around a 20ms startup hit. I don't
    # remember why I needed to get POSIX-compliant function names,
    # so if it comes back up be sure to write down a reminder
    # [[ -f ~/.fzf.bash ]] && source ~/.fzf-mine.sh
    ;;
esac

export SSL_CERT_DIR=/etc/ssl/certs

# .bash_functions/bash-profile.sh sets the correct VIRTUAL_ENV position
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Alias batcat if we must
if command -v batcat &> /dev/null; then
    alias bat="batcat"
fi

# For info files
export INFOPATH="/usr/local/share/info:/usr/share/info/emacs:/usr/share/info"

# If we need the conda --init stuff, put it over in .conda_profile
[ -f $HOME/.conda_profile ] &&  source "$HOME/.conda_profile"

# vterm shell-side configuration
# https://github.com/akermu/emacs-libvterm#shell-side-configuration
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# Conda aliases
_ca() {
	awk '/name:/ { print $2 }' environment.yml
}
alias ca='conda activate $(_ca)'

# Late machine-specific specs
[ -f "$HOME/.locals" ] && source "$HOME/.locals"
