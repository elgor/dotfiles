
#!/usr/bin/env bash
# Description: get transmission/received data amount of current net interface


case $1 in
	now) wget -q -t 2 -T 5 -O- "m.accuweather.com/en/de/munich/80331/daily-weather-forecast/178086?day=1" | sed -n '50,150{/var apgWxInfoObj/,+10 s/.*cu:.*hi: .\([0-9-]*\).*/\1°C/p}';;
	today) wget -q -t 2 -T 5 -O- "m.accuweather.com/en/de/munich/80331/daily-weather-forecast/178086?day=1" | sed -n '/<div class="weather-block">/,/Hours of Precip /{s/.*RealFeel.*<b>\([0-9]*\).*/\1°C, /p; s/.*Hours of Precip <b>\([0-9]*\).*/\1h/p;}' | sed 'N;s/\n//g';;
	tomorrow) wget -t 2 -T 5 -q -O- "m.accuweather.com/en/de/munich/80331/daily-weather-forecast/178086?day=2" | sed -n '/<div class="weather-block">/,/Hours of Precip /{s/.*RealFeel.*<b>\([0-9-]*\).*/\1°C, /p; s/.*Hours of Precip <b>\([0-9]*\).*/\1h/p;}' | sed 'N;s/\n//g';;
	*) wget -q -t 2 -O- "m.accuweather.com/en/de/munich/80331/daily-weather-forecast/178086?day=1" | sed -n '50,150{/var apgWxInfoObj/,+10 s/.*cu:.*hi: .\([0-9-]*\).*/\1°C/p}';;
esac

exit 0

# wget -q -O- "http://api.openweathermap.org/data/2.5/weather?q=munich&units=metric" | sed -n 's/.*"main":"\([a-zA-Z]*\)".*"temp_min":\([-0-9]*\).*"temp_max":\([-0-9]*\).*/\1 \2°\/\3°/p'
# wget -q -O- "http://api.openweathermap.org/data/2.5/forecast/daily?q=melbourne,au&units=metric&cnt=2" | sed -n 's/.*"min":\([-0-9]*\).*"max":\([-0-9]*\).*"main":"\([a-zA-Z]*\)".*"min":\([-0-9]*\).*"max":\([-0-9]*\).*"main":"\([a-zA-Z]*\)".*/Today:    \3 \1°\|\2°\nTomorrow: \6 \4°\|\5°/p'

# OpenWeatherMap
# wget -q -O- "http://api.openweathermap.org/data/2.5/weather?q=melbourne,au&units=metric" | sed -n 's/.*"main":"\([a-zA-Z]*\)".*"temp":\([-0-9]*\).*/\1 \2°/p'

# AccuWeather
# wget -q -O- "m.accuweather.com/en/au/melbourne/26216/daily-weather-forecast/26216?day=1" | sed -n '/<div class="weather-block">/,/Hours of Precip /{;s/.*<p>\([a-Z ,]*\)<\/p>.*/\1/p; s/.*RealFeel.*<b>\([0-9]*\).*/Temp: \1°C /p; s/.*Hours of Precip <b>\([0-9]*\).*/Precip: \1h/p;}' | sed 'n;N;s/\n/ /g

# wget -q -O- "m.accuweather.com/en/au/melbourne/26216/daily-weather-forecast/26216?day=1" | sed -n '/<div class="weather-block">/,/Hours of Precip /{s/.*RealFeel.*<b>\([0-9]*\).*/Temp: \1°C /p; s/.*Hours of Precip <b>\([0-9]*\).*/Rain: \1h/p;}' | sed 'N;s/\n/ /g'

