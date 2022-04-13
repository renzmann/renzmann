#! /usr/bin/env bash

# Still need to:
# 1. add-path function that inserts/appends to PATH if something's not on it
# 2. modify funced to work on ~/.bash_functions while ced is on ~/.local/bin

if command -v nvim &> /dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	source /etc/bashrc
fi

# Things that need to be "sourced" instead of loaded on-demand
source $HOME/.git-prompt.sh
for file in $HOME/.bash_functions/*; do
	source $file
done

insert-path /usr/local/bin
insert-path $HOME/.local/bin
insert-path $HOME/.local/share/coursier/bin
insert-path $HOME/.emacs.d/bin
[[ -z $GOPATH ]] && export GOPATH=$HOME/go
insert-path $GOPATH/bin
insert-path $HOME/.cargo/bin

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

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Make <C-q> work in vim
[[ $- == *i* ]] && stty start undef
# Don't hang on ctrl-s https://unix.stackexchange.com/a/12108
[[ $- == *i* ]] && stty -ixon

# nvm setup bits
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

case "$TERM" in
	dumb|emacs*)
		;;
	*)
		[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
		;;
esac

export SSL_CERT_DIR=/etc/ssl/certs

[[ -d $HOME/.jabba ]] && source $HOME/.jabba/jabba.sh
