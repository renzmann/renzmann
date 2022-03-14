# .bashrc

[[ -z $GOPATH ]] && export GOPATH=$HOME/go

local_bin_on_path=$(echo $PATH | grep '/usr/local/bin')
if [[ -z $local_bin_on_path ]]; then
	export PATH=/usr/local/bin:$PATH
fi
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share/coursier/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$GOPATH/bin:$PATH

. $HOME/.git-prompt.sh
. $HOME/.bash_completions/.dbt-completion.bash
. $HOME/.bash_functions/load-funcs.sh && load-funcs

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	screen|*-color|*-256color|dumb) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
	if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
	color_prompt=
	fi
fi

if [[ "$color_prompt" = yes ]]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\n\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
	*)
	;;
esac

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
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

if command -v nvim &> /dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

export SSL_CERT_DIR=/etc/ssl/certs
