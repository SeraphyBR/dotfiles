#!/usr/bin/env bash
filename="$HOME/Video/ScreenRecords/record_$(date +%Y-%m-%d_%H:%M:%S).mkv"

thumb="/tmp/thumb.jpg"

width="1920"
height="1080"
xoffset="0"
yoffset="0"

# pactl list sources
audio_card="alsa_output.pci-0000_00_1f.3.analog-stereo.monitor"

if pgrep ffmpeg; then
    sleep 2
    killall ffmpeg
    sleep 2
    ffmpeg -y -nostats -loglevel 0 -i "$filename" -an -frames:v 1 -ss 3 "$thumb"
    notify-send -i "$thumb" "FFmpeg" "Gravação da tela finalizada!"
    exit 0
fi

# Choose screen to record
connected="$(xrandr | grep " connected " | sed 's/primary//')"
outputs="$(awk '{ print $1,$3 }' <<< "$connected")"

if [ "$(wc -l <<< "$outputs")" -ne 1 ]; then
    monitor="$(rofi -dmenu -p "Escolha um monitor para gravar a tela!" <<< "$outputs" | awk '{print $2}')"
else
    monitor="$(awk '{print $2}' <<< "$outputs")"
fi
IFS=x+ read -r width height xoffset yoffset <<< "$monitor"

notify-send "FFmpeg" "Gravação da tela iniciada!"

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
-y "$filename" &

