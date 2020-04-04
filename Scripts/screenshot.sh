#!/bin/sh
# Shotgun - https://github.com/neXromancers/shotgun
# Hacksaw - https://github.com/neXromancers/hacksaw

tmp="/tmp/$(date +%F_%T).png"
filename="$HOME/Imagens/Screenshots/$(date +%F_%T).png"

bw="$(bspc config border_width)"
bc="$(bspc config focused_border_color)"

sleep 1
if [ "$1" = "-s" ]; then
    shotgun -g "$(hacksaw -n -s "$bw" -c "$bc")" "$tmp"
else
    shotgun "$tmp"
fi

if mv "$tmp" "$filename"
then
    notify-send -i "$filename"  "Screenshot" "Capture saved to '$filename'"
    xclip -selection clipboard -t image/png "$filename"
elif [ ! -f "$tmp" ]; then
    notify-send "Screenshot" "Operation canceled"
else
    notify-send -i "$tmp"  "Screenshot" "Capture saved to '$tmp'"
    xclip -selection clipboard -t image/png "$tmp"
fi
