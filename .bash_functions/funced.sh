funced () {
  vim $HOME/.bash_functions/$(basename $1).sh && load-funcs
}
