#!/usr/bin/env bash
funced() {
	if command -v nvim &> /dev/null; then
		local editor=nvim
	else
		local editor=vim
	fi

	local funcname=$(basename $1)
	local fp=$HOME/.bash_functions/${funcname}.sh
	local template="#!/usr/bin/env bash\n${funcname}()\n{	\n}\n"
	[[ ! -f $fp ]] && cat > $fp << EOF
#!/usr/bin/env bash
${funcname}() {
	echo hello
}
EOF
	$editor +3 $fp && load-funcs
}

_funced() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local funcs=$(declare -F | awk '{ print $3 }' | tr '\n' ' ')
	COMPREPLY=( $(compgen -W "$funcs" -- $cur) )
}

complete -F _funced funced
