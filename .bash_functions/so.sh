so() {
  if [ -z "$1" ]; then
    local name=".venv"
  else
    local name="$1"
  fi

  source $name/bin/activate
}
