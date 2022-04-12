#!/usr/bin/env bash
bash-prompt() {
	# set a fancy prompt (non-color, unless we know we "want" color)
	case "$TERM" in
		screen|*-color|*-256color|dumb) color_prompt=yes;;
	esac

	# force_color_prompt=yes
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
		PS1="${debian_chroot:+($debian_chroot)}${LIGHT_BLUE}\u${LIGHT_GRAY}@${YELLOW}\h${LIGHT_GRAY}:${CYAN}$(abbrev-pwd)${LIGHT_GRAY}$(__git_ps1)${COLOR_RESET}\n> "
	else
		PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\n\$ "
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
}
