#!/usr/bin/env bash
_csync() {
	# Stop ignoring anything that's been removed since the last
	# call to `funced`
	local current_ignores
	current_ignores=$(grep '!.local/bin/*' < "$HOME/.gitignore" | awk -F '/' '{ print $3 }' | tr '\n' ' ')

	for f in $current_ignores; do
		if [[ ! -f "$HOME/.local/bin/$f" ]]; then
			local to_remove='!.local\/bin\/'"$f"
			sed -i /^"${to_remove}"\$/d "$HOME/.gitignore"
		fi
	done
}

_csave() {
	# Add the most recently edited function to version control
	local ignore_str='!.local/bin/'"$1"
	! grep -q "$ignore_str" "$HOME/.gitignore" \
		&& echo "$ignore_str" >> "$HOME/.gitignore" \
		&& chmod u+x "$HOME/.local/bin/$1" \
		&& _csync
}

crm() {
	rm "$HOME/.local/bin/$1" && _csync
}

ced() {
	local cname
	cname=$(basename "$1")
	local fp=$HOME/.local/bin/${cname}
	[[ ! -f "$fp" ]] && cat > "$fp" << EOF
#!/usr/bin/env bash
_${cname}() {
	echo hello
}
_${cname} \$@
EOF
	$EDITOR +2 "$fp" && _csave "$cname"
}

_ced() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local funcs
	funcs=$(grep '!.local/bin/*' "$HOME/.gitignore" | awk -F '/' ' { print $3 }')
	# "Prefer mapfile or read -a" -- I can't figure this one out, bash official docs recommend the below
	COMPREPLY=( $(compgen -W "$funcs" -- "$cur") )
}

complete -F _ced ced
complete -F _ced crm
