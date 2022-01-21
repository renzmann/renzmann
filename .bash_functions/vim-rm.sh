vim-rm() {
  local IFS='/'
  set -- $1
  local author=$1
  local plugin=$2
  rm -rf $HOME/.vim/pack/$author/start/$plugin
}

