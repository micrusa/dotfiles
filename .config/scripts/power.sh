#!/usr/bin/bash

STATE=""
BAT="BAT1"

if [[ "$1" == "BAT" || "$1" == "AC" ]]; then
  STATE="$1"
fi

if [[ $STATE == "" ]]; then
  if [[ $(upower -i /org/freedesktop/UPower/devices/battery_$BAT | grep state | grep discharging) == "" ]]; then
    STATE="AC"
  else STATE="BAT"
  fi
fi

echo $STATE

if [[ $STATE == "BAT" ]]; then
  echo "Discharging, set governor to ondemand & screen 60hz"
  xrandr --output HDMI-1-0 --primary --mode 1920x1080 --rate 75.0 --output eDP-1 --mode 1920x1080 --rate 60.0 --right-of HDMI-1-0
#  sudo cpupower frequency-set -g ondemand
elif [[ $STATE == "AC"  ]]; then
  echo "AC plugged in, set governor to performance & screen 120hz"
  xrandr --output HDMI-1-0 --primary --mode 1920x1080 --rate 75.0 --output eDP-1 --mode 1920x1080 --rate 144.0 --right-of HDMI-1-0
#  sudo cpupower frequency-set -g performance
fi
