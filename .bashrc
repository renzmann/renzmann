#! /usr/bin/env bash
if command -v nvim &> /dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

local_bin_on_path=$(echo $PATH | grep '/usr/local/bin')
[[ -z $local_bin_on_path ]] && export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share/coursier/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
[[ -z $GOPATH ]] && export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
[[ -z $(echo $PATH | grep '.cargo/bin') ]] && export PATH=$HOME/.cargo/bin:$PATH

. $HOME/.git-prompt.sh
. $HOME/.bash_completions/.dbt-completion.bash
# . $HOME/.bash_functions/load-funcs.sh
# load-funcs

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Add function editing and completion of names
source funced

# Set the prompt
source bash-prompt

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
