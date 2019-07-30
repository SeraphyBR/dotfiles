#!/bin/sh

while true
do
    mpc idle player > /dev/null 2>&1
    NOTIFY_TITLE="Now Playing"
    MUSIC_INFO=$(mpc current -f "%title%\\n%artist% - %album%")
    FILE=$(mpc current -f "%file%")
    DIR="$HOME/Música/$FILE"
    if ffmpeg -nostats -loglevel 0 -y -i "$DIR" /tmp/cover.jpg
    then
        IMG="/tmp/cover.jpg"
    else
        IMG="/usr/share/icons/Papirus/48x48/categories/audio-player.svg"
    fi
    dunstify -u low -t 5000 -a MPD -r 1337 -i "$IMG" "$NOTIFY_TITLE"  "$MUSIC_INFO"
done
