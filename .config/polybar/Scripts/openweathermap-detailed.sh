#!/usr/bin/env bash

get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="";
    esac

    echo $icon
}

KEY="c58f0bfae5e205dcbf13f7166e8356a7"
CITY="6321162"
UNITS="Metric"
SYMBOL="°C"

if [ ! -z $CITY ]; then
    weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$CITY&units=$UNITS")
    # weather=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ ! -z "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"
        weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ ! -z "$weather" ]; then
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

######################  Translate section  ##################################
    if [ "$weather_desc" = "shower rain" ]; then 
        weather_desc="Chuva torrencial"
    elif [ "$weather_desc" = "overcast clouds" ]; then 
        weather_desc="Nublado"
    elif [ "$weather_desc" = "scattered clouds" ]; then 
        weather_desc="Nuvens esparsas"
    elif [ "$weather_desc" = "thunderstorm" ]; then 
        weather_desc="Trovoada"
    elif [ "$weather_desc" = "thunderstorm with light rain" ]; then 
        weather_desc="Trovoada com chuva fina"
    elif [ "$weather_desc" = "few clouds" ]; then
        weather_desc="Poucas nuvens"
    elif [ "$weather_desc" = "broken clouds" ]; then 
        weather_desc="Nuvens esparsas"
    elif [ "$weather_desc" = "clear sky" ]; then 
            weather_desc="Céu claro"
    elif [ "$weather_desc" = "moderate rain" ]; then 
        weather_desc="Chuva moderada"
    elif [ "$weather_desc" = "thunderstorm with heavy rain" ]; then 
        weather_desc="Trovoada com chuva pesada"
    elif [ "$weather_desc" = "light rain" ]; then 
        weather_desc="Chuva leve"
    elif [ "$weather_desc" = "light intensity shower rain" ]; then 
        weather_desc="Chuva leve"
    elif [ "$weather_desc" = "mist" ] || [ "$weather_desc" = "fog" ]; then 
        weather_desc="Névoa"
    elif [ "$weather_desc" = "haze" ]; then
        weather_desc="neblina"
    elif [ "$weather_desc" = "light intensity drizzle" ]; then
        weather_desc="Chuvisco leve"
    fi 
############################################################################

# https://github.com/jaagr/polybar/wiki/Fonts 
#; Using raw formatting tags, you can mix fonts.
#; %{T3} tells the bar to use Noto Sans and %{T-} resets it to default.
#label-inactive = %{T3}Inactive%{T-} %time%

    echo  "$weather_desc", "$weather_temp$SYMBOL" "%{T4}%{F#00BFFF}$(get_icon "$weather_icon")%{F-}%{T-}"
fi
