#!/usr/bin/env bash
bash-prompt() {
	# set a fancy prompt (non-color, unless we know we "want" color)
	local deb_part='${debian_chroot:+($debian_chroot)}'
	local user_part=${LIGHT_BLUE}$(trunc-string -n 20 $(echo ${USER} | awk -F '.' '{ print $1 }'))${COLOR_RESET}
	local user_sep=${LIGHT_GRAY}@${COLOR_RESET}
	local host_part=${YELLOW}$(trunc-string -n 20 $(echo ${HOSTNAME} | awk -F '.' '{ print $1 }'))${COLOR_RESET}
	local dir_sep=${LIGHT_GRAY}:${COLOR_RESET}
	local dir_part=${CYAN}'$(abbrev-pwd)'${COLOR_RESET}
	local git_part=${LIGHT_RED}'$(__git_ps1)'${COLOR_RESET}
	local prompt_part='\n'${GREEN}'>'${COLOR_RESET}' '
	# local force_color_prompt=yes

	case "$TERM" in
		screen|*-color|*-256color|dumb)
			local color_prompt=yes
			;;
		*)
			;;
	esac

	if [[ -n "$force_color_prompt" ]]; then
		if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
			# We have color support; assume it's compliant with Ecma-48
			# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
			# a case would tend to support setf rather than setaf.)
			local color_prompt=yes
		else
			local color_prompt=
		fi
	fi

	if [[ "$color_prompt" = yes ]]; then
		PS1=${deb_part}${user_part}${user_sep}${host_part}${dir_sep}${dir_part}${git_part}${prompt_part}
	else
		PS1=${deb_part}'\u@\h:\w$(__git_ps1)\n\$ '
	fi
}
