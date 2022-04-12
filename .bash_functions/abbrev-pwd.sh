#!/usr/bin/env bash
abbrev-pwd() {
	p="${PWD#${HOME}}"
	[ "${PWD}" != "${p}" ] && printf "~"
	IFS=/
	for q in ${p:1}
		do printf /${q:0:1}
	done
	printf "${q:1}"
}
