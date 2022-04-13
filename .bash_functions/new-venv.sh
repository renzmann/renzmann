#!/usr/bin/env bash
new-venv() {
	local name=${1:-.venv}
	local version=${2:-3}

	python${version} -m venv $name \
		&& source $name/bin/activate \
		&& python${version} -m pip install --upgrade pip wheel
}
