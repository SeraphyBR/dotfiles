#!/bin/sh

ICON="/usr/share/icons/Papirus/48x48/devices/battery.svg"
BAT="/sys/class/power_supply/BAT0"

while sleep 400
do
    read -r STATUS < $BAT/status
    read -r LEVEL < $BAT/capacity
    if [ "$STATUS" = "Charging" ]; then
        if [ "$LEVEL" -eq 100 ]; then
            notify-send -i $ICON "Bateria está carrega!" "Pode remover da tomada!"
        fi
    else
        if [ "$LEVEL" -le 15 ]; then
            notify-send -u critical -i $ICON "Bateria está abaixo de 15%!" "Precisa carregar! Por favor plugue o na tomada!."
        fi
    fi
done
