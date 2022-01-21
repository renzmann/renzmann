ff() {
  find . -path ./.venv -prune -o -name "$1" -print
}
