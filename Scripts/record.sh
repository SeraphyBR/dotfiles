#!/bin/sh

tmp="/tmp/record_$(date +%Y-%m-%d).mkv"
filename="$HOME/Vídeos/ScreenRecords/record_$(date +%Y-%m-%d_%H:%M).mkv"

width="1920"
height="1080"

x="0"
y="0"

# pactl list sources
audio_card="alsa_output.pci-0000_00_1f.3.analog-stereo.monitor"

if pgrep ffmpeg; then
    killall ffmpeg
    notify-send "FFmpeg" "Gravação da tela finalizada!"
    mv "$tmp" "$filename"
    exit 0
fi

notify-send "FFmpeg" "Gravação da tela iniciada!"

ffmpeg -nostats -loglevel 0 -s ${width}x${height} \
-f x11grab \
-i :0.0+${x},${y} \
-f pulse \
-ac 2 \
-i "$audio_card" \
-c:v libx264 \
-crf 19 \
-r 30 \
-c:a libopus \
-b:a 72k \
-y "$tmp" &

