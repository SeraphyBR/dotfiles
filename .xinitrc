#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . "$HOME"/.xprofile

if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

xrandr --auto

exec  awesome


