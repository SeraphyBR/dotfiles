#!/usr/bin/env sh

filename="$HOME/Imagens/Screenshots/$(date +%F_%T).png"

if [ "$1" = "-s" ]
then
    maim --select -d 1 --bordersize 6 --color=0.23,0.70,0.30,0.8  "$filename"
else
    maim -d 1 "$filename"
fi

notify-send -i "$filename"  "Screenshot" "Capture saved to '$filename'"

xclip -selection clipboard -t image/png "$filename"
