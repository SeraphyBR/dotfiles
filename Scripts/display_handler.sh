#!/bin/sh
#
# Script for use with srandrd - (https://github.com/jceb/srandrd)
#

mydotfiles="$HOME/Git/DotFiles"
dot_s="$mydotfiles/Scripts"
dot_i="$mydotfiles/Images"

{
    case "$SRANDRD_OUTPUT $SRANDRD_EVENT" in
        "HDMI-0 connected")
            bspc monitor HDMI-0  -d I II III IV V
            bspc monitor eDP-1-1 -d VI VII VIII IX X
            xrandr --output HDMI-0  --primary --auto --left-of eDP-1-1
            "$HOME"/.config/polybar/launch.sh
            "$dot_s"/wallblur/wallblur.sh -o "$dot_i"/Wallpapers &
            ;;
        "HDMI-0 disconnected")
            xrandr --output HDMI-0 --off
            bspc monitor eDP-1-1 -d I II III IV V VI VII VIII IX X
            "$HOME"/.config/polybar/launch.sh
            "$dot_s"/wallblur/wallblur.sh -o "$dot_i"/Wallpapers &
            ;;
        "VGA-0 connected") 
            xrandr --output VGA-0 --auto --left-of eDP-1
            ;;
    esac

    notify-send "srandrd" "$SRANDRD_OUTPUT $SRANDRD_EVENT"
} &
