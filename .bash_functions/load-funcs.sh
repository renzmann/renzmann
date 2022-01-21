load-funcs() {
  for file in $HOME/.bash_functions/*; do
    . $file
  done
}

_funced() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local funcs=$(declare -F | awk '{ print $3 }' | tr '\n' ' ')
    COMPREPLY=( $(compgen -W "$funcs" -- $cur) )
}

complete -F _funced funced
