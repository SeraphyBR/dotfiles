

if [ -z "$DISPLAY" ] && [ "$TTY" = "/dev/tty1" ]
then
    exec startx &> /dev/null
fi
