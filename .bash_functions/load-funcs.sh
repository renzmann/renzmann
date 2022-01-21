load-funcs() {
  for file in $HOME/.bash_functions/*; do
    . $file
  done
}

