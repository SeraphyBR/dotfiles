# Auto startx for tty1

if [ -z "$DISPLAY" ] && [ "$TTY" = "/dev/tty1" ]
then
    exec startx -- vt1 > /dev/null 2>&1
fi

