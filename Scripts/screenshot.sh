#!/bin/sh

tmp="$HOME/$(date +%F_%T).png"
filename="$HOME/Imagens/Screenshots/$(date +%F_%T).png"

if [ "$1" = "-s" ]
then
    maim --select -k -d 1 --bordersize 6 --color=0.23,0.70,0.30,0.8  "$tmp"
else
    maim -d 1 "$tmp"
fi

if mv "$tmp" "$filename"
then
    notify-send -i "$tmp"  "Screenshot" "Capture saved to '$filename'"
    xclip -selection clipboard -t image/png "$filename"
else
    notify-send -i "$tmp"  "Screenshot" "Capture saved to '$tmp'"
    xclip -selection clipboard -t image/png "$tmp"
fi
