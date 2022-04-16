#!/usr/bin/env bash
funced() {
	local funcname=$(basename $1)
	local fp=$HOME/.bash_functions/${funcname}.sh
	local template="#!/usr/bin/env bash\n${funcname}()\n{	\n}\n"
	[[ ! -f $fp ]] && cat > $fp << EOF
#!/usr/bin/env bash
${funcname}() {
	echo hello
}
EOF
	$EDITOR +3 $fp

	for file in $HOME/.bash_functions/*; do
		source $file
	done
}

_funced() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local funcs=$(ls $HOME/.bash_functions | sed 's/\.sh$//' | tr '\n' ' ')
	COMPREPLY=( $(compgen -W "$funcs" -- $cur) )
}

complete -F _funced funced
