#!/usr/bin/env bash
sqlfmt() {
	command -v cli-sql-formatter &> /dev/null || sudo npm install -g cli-sql-formatter
	cli-sql-formatter -u -i 4 -f $1 > $1
}
