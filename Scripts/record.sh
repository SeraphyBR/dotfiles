#!/bin/sh

if pgrep ffmpeg; then
    killall ffmpeg
    notify-send "FFmpeg" "Gravação da tela finalizada!"
    exit 0
fi

set $(slop -q -o -f '%x %y %w %h')

FILE="$HOME/Vídeos/record_$(date +%d-%m-%Y_%H:%M).mkv"
# pactl list sources
AUDIO_CARD="alsa_output.pci-0000_00_1f.3.analog-stereo.monitor"

notify-send "FFmpeg" "Gravação da tela iniciada!"

ffmpeg -nostats -loglevel 0 -s ${3}x${4} \
-f x11grab \
-i :0.0+${1},${2} \
-f pulse \
-ac 2 \
-i "$AUDIO_CARD" \
-c:v libx264 \
-crf 19 \
-r 30 \
-c:a libopus \
-b:a 72k \
-y "$FILE" &
