#!/usr/bin/env bash
so() {
	local name=${1:-.venv}
	local version=${2:-3}

	if [[ ! -d $name ]]; then
		python${version} -m venv $name \
			&& source $name/bin/activate \
			&& python${version} -m pip install --upgrade pip wheel
	else
		source $name/bin/activate
	fi
}
