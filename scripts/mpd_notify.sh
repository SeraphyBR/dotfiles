#!/bin/sh
# Originally created by MORG4R37H

fallback_icon="/etc/profiles/per-user/seraphybr/share/icons/Papirus/48x48/categories/audio-player.svg"

{
    while true
    do
        mpc idle player > /dev/null 2>&1
        NOTIFY_TITLE="Now Playing"
        MUSIC_INFO=$(mpc current -f "%title%\\n%artist% - %album%")
        FILE=$(mpc current -f "%file%")
        DIR="$HOME/Music/$FILE"
        if ffmpeg -nostats -loglevel 0 -y -i "$DIR" /tmp/cover.jpg
        then
            IMG="/tmp/cover.jpg"
        else
            IMG=$fallback_icon
        fi
        notify-send -u low -t 5000 -i "$IMG" "$NOTIFY_TITLE"  "$MUSIC_INFO"
    done
} &
