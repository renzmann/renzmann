#!/usr/bin/env bash
append_path() {
	[[ ! "$PATH" == "*${1}*" ]] && export PATH="${PATH:+${PATH}:}${1}"
}

insert_path() {
	[[ ! "$PATH" == "*${1}*" ]] && export PATH="${1}${PATH:+:${PATH}}"
}
