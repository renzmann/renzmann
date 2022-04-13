#!/usr/bin/env bash
so() {
	local name=${1:-.venv}
	if [[ ! -d $name ]]; then
		new-venv $name
	else
		source $name/bin/activate
	fi
}
