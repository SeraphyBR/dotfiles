#! /usr/bin/env sh
#
# Script for use with srandrd - (https://github.com/jceb/srandrd)
#
{

    case "$SRANDRD_OUTPUT $SRANDRD_EVENT" in
        "HDMI-1 connected") 
            bspc monitor HDMI-1  -d I II III IV V 
            bspc monitor eDP-1 -d VI VII VIII IX X 
            xrandr --output HDMI-1  --primary --auto --right-of eDP-1
            ~/.config/polybar/launch.sh
            feh --bg-tile ~/DotFiles/Images/Wallpapers/road_trees_top_view_119030_1920x1080.jpg
            ;;
        "HDMI-1 disconnected")
            xrandr --output HDMI-1 --off
            bspc monitor eDP-1 -d I II III IV V VI VII VIII IX X
            ~/.config/polybar/launch.sh
            hsetroot -center ~/DotFiles/Images/Wallpapers/road_trees_top_view_119030_1920x1080.jpg 
            ;;
        "VGA-0 connected") xrandr --output VGA-0 --auto --left-of eDP-1;;
    esac


    notify-send "srandrd" "$SRANDRD_OUTPUT $SRANDRD_EVENT"
} & # Group all the commands and run them in the background. srandrd waits for
# the script to exit before continuing. That means it'll wait for this script to
# return, then run it again because of the xrandr command above. That makes our
# lockfile useless. Putting all the commands in the background means that the
# script returns immediately, runs the script a second time, and our lockfile
# above blocks it.
