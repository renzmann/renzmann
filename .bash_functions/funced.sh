funced() {
  vim $HOME/.bash_functions/$(basename $1).sh && load-funcs
}

_funced() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local funcs=$(declare -F | awk '{ print $3 }' | tr '\n' ' ')
    COMPREPLY=( $(compgen -W "$funcs" -- $cur) )
}

complete -F _funced funced
