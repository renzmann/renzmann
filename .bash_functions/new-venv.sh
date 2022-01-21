new-venv () {
  if [ -z "$1" ]; then
    local name=".venv"
  else
    local name="$1"
  fi

  python3 -m venv $name \
    && source $name/bin/activate \
    && python3 -m pip install --upgrade pip wheel
}

