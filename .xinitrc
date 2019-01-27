#!/usr/bin/env sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile


dbus="ck-launch-session dbus-launch --sh-syntax --exit-with-session" 

case $2 in
    bspwm) exec $dbus bspwm ;;
    herb) exec $dbus herbstluftwm ;;
    *) exec $dbus bspwm ;;
esac

# Use: startx bspwm (to start bspwm)
#      startx herb (to start, in this case, herbstluftwm)
#      startx (without arguments, to start bspwm)
