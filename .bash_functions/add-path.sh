#!/usr/bin/env bash
append_path() {
	local on_path=$(echo $PATH | grep $1)
	[[ -z $on_path ]] && export PATH=$PATH:${1}
}

insert_path() {
	local on_path=$(echo $PATH | grep $1)
	[[ -z $on_path ]] && export PATH=${1}:$PATH
}
