#! /bin/sh
#
# player.sh
# Copyright (C) 2019 seraphybr-fun <seraphybr-fun@funtoo-z40>
#
# Distributed under terms of the MIT license.
#

case "$1" in 
    "play-pause")
        playerctl play-pause
        mpc -q toggle
        ;;
    "stop") 
        playerctl stop
        mpc -q stop
        ;;
    "next") 
        playerctl next
        mpc -q next
        ;;
    "prev") 
        playerctl previous
        mpc -q prev
        ;;
    *) ;;
esac
