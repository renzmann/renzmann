#!/usr/bin/env bash
_csync() {
	# Stop ignoring anything that's been removed since the last
	# call to `funced`
	local current_ignores=$(cat $HOME/.gitignore | grep '!.local/bin/*' | awk -F '/' '{ print $3 }' | tr '\n' ' ')
	for f in $current_ignores; do
		if [[ ! -f $HOME/.local/bin/$f ]]; then
			local to_remove='!.local\/bin\/'"$f"
			sed -i /$to_remove/d $HOME/.gitignore
		fi
	done
}

_csave() {
	# Add the most recently edited function to version control
	local ignore_str='!.local/bin/'"$1"
	[[ -z $(cat $HOME/.gitignore | grep -x ${ignore_str}) ]] \
		&& echo ${ignore_str} >> $HOME/.gitignore \
		&& chmod u+x "$HOME/.local/bin/$1" \
		&& _csync
}

crm() {
	rm "$HOME/.local/bin/$1" && _csync
}

ced() {
	local cname=$(basename $1)
	local fp=$HOME/.local/bin/${cname}
	local template="#!/usr/bin/env bash\n${cname}()\n{	\n}\n"
	[[ ! -f $fp ]] && cat > $fp << EOF
#!/usr/bin/env bash
_${cname}() {
	echo hello
}
_${cname} \$@
EOF
	$EDITOR +2 $fp && _csave $cname
}

_ced() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local funcs=$(cat $HOME/.gitignore | grep '!.local/bin/*' | awk -F '/' ' { print $3 }')
	COMPREPLY=( $(compgen -W "$funcs" -- $cur) )
}

complete -F _ced ced
complete -F _ced crm
