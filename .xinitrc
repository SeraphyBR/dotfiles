#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . "$HOME"/.xprofile


dbus="dbus-launch --sh-syntax --exit-with-session" 

# Reverse Prime
xrandr --setprovideroutputsource 1 0
xrandr --auto

case $2 in
    bspwm) exec $dbus bspwm ;;
    awesome) exec $dbus awesome ;;
    *) exec $dbus bspwm ;;
esac

# Use: startx bspwm (to start bspwm)
#      startx awesome (to start, in this case, awesome)
#      startx (without arguments, to start bspwm)
