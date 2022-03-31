new-venv() {
	local name=${1:-.venv}

	python3 -m venv $name \
		&& source $name/bin/activate \
		&& python3 -m pip install --upgrade pip wheel
}

