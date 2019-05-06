#!/usr/bin/env bash

awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc | column -t -s $'\t' | rofi -dmenu -scroll-method 1 -width 70 -p "Keybindings: "
