pywhere() {
  python -c "import $1; print($1.__file__)"
}
