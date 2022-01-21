vim-add() {
  local arg="$1"
  local branch="$2"
  local IFS='/'
  set -- $arg
  local author="$1"
  local plugin="$2"
  if [ -z $branch ]; then local branch="master"; fi
  cd $HOME
  git subtree add -P .vim/pack/$author/start/$plugin git@github.com:$author/$plugin $branch --squash
  cd -
}

