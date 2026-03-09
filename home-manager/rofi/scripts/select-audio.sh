#!/usr/bin/env bash

pactl set-default-sink "$(
pactl list sinks |
awk -F': ' '/Name: / {name=$2} /Description: / {print $2 "|" name}' |
sort -f |
rofi -dmenu -p "" -theme-str 'window { width: 25%; }' |
cut -d'|' -f2
)"
