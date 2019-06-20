#! /bin/sh

while true
do
    mpc idle player 
    NOTIFY_TITLE="Now Playing"
    MUSIC=$(mpc current -f "%title%\\n%artist% - %album%")
    FILE=$(mpc status -f '%file%' | head -n1)
    DIR="$HOME/Música/$FILE"
    if ffmpeg -nostats -loglevel 0 -y -i "$DIR" /tmp/cover.jpg
    then 
        IMG="/tmp/cover.jpg"
    else
        IMG="/usr/share/icons/Papirus/48x48/categories/audio-player.svg"
    fi
    dunstify -u low -t 5000 -a MPD -r 1337 -i "$IMG" "$NOTIFY_TITLE"  "$MUSIC"
done
