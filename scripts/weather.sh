#!/bin/bash

# 天气查询脚本 - 使用 Open-Meteo API (免费无需 key)
# 深圳: latitude=22.54, longitude=114.06

CITY="深圳"
LAT="22.54"
LON="114.06"
TZ="Asia/Shanghai"

RESPONSE=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current_weather=true&timezone=$TZ")

TEMP=$(echo "$RESPONSE" | jq -r '.current_weather.temperature')
WIND=$(echo "$RESPONSE" | jq -r '.current_weather.windspeed')
CODE=$(echo "$RESPONSE" | jq -r '.current_weather.weathercode')

# 天气代码转中文
case $CODE in
  0) WEATHER="☀️ 晴" ;;
  1|2|3) WEATHER="⛅️ 多云" ;;
  45|48) WEATHER="🌫️ 雾" ;;
  51|53|55) WEATHER="🌧️ 毛毛雨" ;;
  61|63|65) WEATHER="🌧️ 雨" ;;
  71|73|75) WEATHER="❄️ 雪" ;;
  80|81|82) WEATHER="🌧️ 阵雨" ;;
  95|96|99) WEATHER="⛈️ 雷暴" ;;
  *) WEATHER="🌤️ 一般" ;;
esac

echo "📍 $CITY"
echo "🌤️ 天气: $WEATHER"
echo "🌡️ 温度: ${TEMP}°C"
echo "💨 风速: ${WIND} km/h"
