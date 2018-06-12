#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=eDP1 polybar seraphybr -r &
MONITOR=HDMI1 polybar seraphybr -r &
MONITOR=eDP1 polybar seraphybr_bottom -r &
MONITOR=HDMI1 polybar seraphybr_bottom -r &
echo "Bars launched..."
dunstify -u low  "Bars launched"
