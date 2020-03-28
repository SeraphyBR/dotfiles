#!/bin/sh
filename="$HOME/Vídeos/ScreenRecords/record_$(date +%Y-%m-%d_%H:%M:%S).mkv"
tmpfile="$HOME/current_record_$(date +Y-%m-%d).mkv"

thumb="/tmp/thumb.jpg"

width="1920"
height="1080"

xoffset="0"
yoffset="0"

# pactl list sources
audio_card="alsa_output.pci-0000_00_1f.3.analog-stereo.monitor"

if pgrep ffmpeg; then
    killall ffmpeg
    ffmpeg -y -nostats -loglevel 0 -i "$tmpfile" -an -frames:v 1 -ss 3 "$thumb"
    dunstify -I "$thumb" "FFmpeg" "Gravação da tela finalizada!"
    mv "$tmpfile" "$filename"
    exit 0
fi

dunstify "FFmpeg" "Gravação da tela iniciada!"

ffmpeg -nostats -loglevel 0 -s ${width}x${height} \
-f x11grab \
-i :0.0+${xoffset},${yoffset} \
-f pulse \
-ac 2 \
-i "$audio_card" \
-c:v libx264 \
-crf 19 \
-r 30 \
-c:a libopus \
-b:a 72k \
-y "$tmpfile" &

