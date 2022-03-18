#!/usr/bin/env bash
mail() {
	tail -n "${1:-20}" /var/spool/mail/$USER
}
