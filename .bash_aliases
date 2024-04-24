#!/usr/bin/env sh
alias ec='emacsclient -a nano'
alias cdtop='cd $(git rev-parse --show-toplevel)'

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

# Conda aliases
_ca() {
        awk '/name:/ { print $2 }' environment.yml
}
alias ca='conda activate $(_ca)'
alias mm='micromamba'
alias mmd='micromamba deactivate'
alias mma='micromamba activate'

# Gcloud aliases
alias glogin='gcloud auth login --update-adc'
alias gs='gcloud storage'

# Alias batcat if we must
command -v batcat &> /dev/null && alias bat="batcat"
