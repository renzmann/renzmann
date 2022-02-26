#!/usr/bin/env bash
install-language-servers() {
	npm install -g pyright
	npm install -g bash-language-server

	mkdir -p $HOME/tmp && cd $HOME/tmp
	go install golang.org/x/tools/gopls@latest
	cd -
}

