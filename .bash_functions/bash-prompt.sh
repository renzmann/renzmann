#!/usr/bin/env bash
# This script is meant to be `source`d!
_trunc() {
    $HOME/.local/bin/trunc -n 20 "$(echo ${1} | awk -F '.' '{ print $1 }')"
}

_venv() {
    [[ ! -z $VIRTUAL_ENV ]] && echo '('$(basename $VIRTUAL_ENV)') '
}

_conda() {
    [[ ! -z $CONDA_PREFIX ]] && echo '['🐍$(basename "$CONDA_PREFIX")'] '
}

_bash_prompt() {
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
    # ᚠ U+16A0 Norse Fé Rune
    # set a fancy prompt (non-color, unless we know we "want" color)
    local deb_part='${debian_chroot:+($debian_chroot)}'
    local user_part=${BOLD_GREEN}$(_trunc ${USER})${COLOR_RESET}
    local user_sep=${BOLD_GREEN}@${COLOR_RESET}
    local host_part=${BOLD_GREEN}$(_trunc ${HOSTNAME})${COLOR_RESET}
    local dir_sep=' '
    local dir_part=${BOLD_BLUE}'$(abbrev-pwd)'${COLOR_RESET}
    local git_part=${BOLD_MAGENTA}'$(__git_ps1 "[ᓺ %s]")'${COLOR_RESET}
    local conn_color=${MAGENTA}
    local prompt_part=${COLOR_RESET}'\n'${conn_color}'└'${MAGENTA}'❯'${COLOR_RESET}' '
    # local force_color_prompt=yes

    case "$TERM" in
        dumb)
            local fancy_prompt=no
            ;;
        screen|*-color|*-256color|*-kitty|*alacritty*)
            local fancy_prompt=yes
            ;;
        *)
            ;;
    esac

    if [[ -n "$force_color_prompt" ]]; then
        if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            local fancy_prompt=yes
        else
            local fancy_prompt=
        fi
    fi

    if [[ "$fancy_prompt" = yes ]]; then
        PS1=${conn_color}'\n┌─ '${COLOR_RESET}
    else
        PS1=''
    fi

    # We want $VIRTUAL_ENV and $CONDA_PREFIX checked on each prompt
    # refresh, so these components are implemented as function calls,
    # and the PS1 variable just holds a reference to be evaulated
    # later
    PS1+='$(_venv)'
    PS1+=${GREEN}'$(_conda)'${COLOR_RESET}
    PS1+=${deb_part}
    PS1+=${user_part}${user_sep}${host_part}
    PS1+=${dir_sep}${dir_part}
    PS1+=' '${git_part}

    if [[ "$fancy_prompt" = yes ]]; then
        PS1+=${prompt_part}
    else
        PS1+='\n> '
    fi
}

_bash_prompt "$@"
