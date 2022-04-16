#!/usr/bin/env bash
_trunc() {
	$HOME/.local/bin/trunc-string -n 20 $(echo ${1} | awk -F '.' '{ print $1 }')
}
_bash-prompt() {
	# Easier to read color codes
	local BLACK="\[\033[0;30m\]"
	local DARK_GRAY="\[\033[1;30m\]"

	local RED="\[\033[0;31m\]"
	local BOLD_RED="\[\033[1;31m\]"

	local GREEN="\[\033[0;32m\]"
	local BOLD_GREEN="\[\033[1;32m\]"

	local YELLOW="\[\033[0;33m\]"
	local BOLD_YELLOW="\[\033[1;33m\]"

	local BLUE="\[\033[0;34m\]"
	local BOLD_BLUE="\[\033[1;34m\]"

	local MAGENTA="\[\033[0;35m\]"
	local BOLD_MAGENTA="\[\033[1;35m\]"

	local CYAN="\[\033[0;36m\]"
	local BOLD_CYAN="\[\033[1;36m\]"

	local LIGHT_GRAY="\[\033[0;37m\]"
	local WHITE="\[\033[1;37m\]"

	local COLOR_RESET="\[\033[00m\]"

	# ┌ U+250C
	# ❭ U+276D
	# ❯ U+276F
	# ⯙ U+2BD9 Astraea
	# ⯘ U+2BD8 Persephone
	# ᓺ U+14FA Canadian Swii
	# set a fancy prompt (non-color, unless we know we "want" color)
	local deb_part='${debian_chroot:+($debian_chroot)}'
	local user_part=${BOLD_YELLOW}$(_trunc ${USER})${COLOR_RESET}
	local user_sep=${BOLD_YELLOW}@${COLOR_RESET}
	local host_part=${BOLD_YELLOW}$(_trunc ${HOSTNAME})${COLOR_RESET}
	local dir_sep=' '
	local dir_part=${BOLD_BLUE}'$(abbrev-pwd)'${COLOR_RESET}
	local git_part=${BOLD_MAGENTA}'$(__git_ps1 "[ᓺ %s]")'${COLOR_RESET}
	local conn_color=${DARK_GRAY}
	local prompt_part=${conn_color}'\n└'${MAGENTA}'❯'${COLOR_RESET}' '
	# local force_color_prompt=yes

	case "$TERM" in
		screen|*-color|*-256color|dumb|*-kitty)
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
		PS1=${conn_color}'┌─ '${COLOR_RESET}${deb_part}${user_part}${user_sep}${host_part}${dir_sep}${dir_part}' '${git_part}${prompt_part}
	else
		PS1=${deb_part}'\u@\h:\w$(__git_ps1)\n\$ '
	fi
}
_bash-prompt $@
