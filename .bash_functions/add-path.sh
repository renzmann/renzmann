# This script is meant to be `source`d!
_not_in_path() {
	local prefixed=$(echo "$PATH" | grep "$1:")
	[[ ! -z "$prefixed" ]] && return 1
	local postfixed=$(echo "$PATH" | grep ":$1")
	[[ ! -z "$postfixed" ]] && return 1
	return 0
}

# TODO should we _move_ an item to the beginning or end if it already exists, instead
# of just ignoring it?
append_path() {
	_not_in_path "$1" && export PATH="${PATH:+${PATH}:}${1}"
}

insert_path() {
	_not_in_path "$1" && export PATH="${1}${PATH:+:${PATH}}"
}
