#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . ~/.xprofile


dbus="dbus-launch --sh-syntax --exit-with-session" 

case $2 in
    bspwm) exec $dbus bspwm ;;
    awesome) exec $dbus awesome ;;
    *) exec $dbus bspwm ;;
esac

# Use: startx bspwm (to start bspwm)
#      startx awesome (to start, in this case, awesome)
#      startx (without arguments, to start bspwm)
