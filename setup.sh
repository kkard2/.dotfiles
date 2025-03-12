#!/bin/bash
set -e

CFG="${XDG_CONFIG_HOME:-$HOME/.config}"
echo $CFG

link_helper () {
	echo "$CFG/$1"
	ln -s "$(realpath ./$1)" "$CFG" || true
}

linux_link_helper () {
	echo "$CFG/$1"
	ln -s "$(realpath ./_linux/$1)" "$CFG" || true
}

link_helper "espanso"
link_helper "nvim"
link_helper "kanata"
link_helper "mpv"

linux_link_helper "tmux"
linux_link_helper "i3"
linux_link_helper "i3status"
