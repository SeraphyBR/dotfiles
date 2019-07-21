#!/bin/sh

ICON="/usr/share/icons/Papirus/48x48/devices/battery.svg"
BAT="/sys/class/power_supply/BAT0"

while true
do
    LEVEL=$(cat "$BAT"/capacity)
    STATUS=$(cat "$BAT"/status)
    if [ "$STATUS" = "Charging" ]; then

        if [ "$LEVEL" -eq 100 ]; then
            notify-send -i $ICON "Bateria está carrega!" "Pode remover da tomada!"
            sleep 120
        elif [ "$LEVEL" -ge 85 ]; then
            notify-send -i $ICON "Bateria está carregando acima de 80%!" "Por favor tire-o da tomada!"
            sleep 120
        fi
    else
        if [ "$LEVEL" -le 15 ]; then
            notify-send -u critical -i $ICON "Bateria está abaixo de 15%!" "Precisa carregar! Por favor plugue o na tomada!."
            sleep 20
        fi
    fi

    sleep 300 # 300 seconds or 5 minutes

done
