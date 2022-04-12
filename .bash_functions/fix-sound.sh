#!/usr/bin/env bash
fix-sound() {
	# https://askubuntu.com/a/1067759
	pulseaudio -k
}
