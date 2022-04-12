#!/usr/bin/env bash
trunc-string() {
	if [[ "$1" = '-n' ]]; then
		local len=$2
		local to_trunc=$3
	else
		local len=10
		local to_trunc=$1
	fi
	echo $to_trunc | awk -v len=$len '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
}
