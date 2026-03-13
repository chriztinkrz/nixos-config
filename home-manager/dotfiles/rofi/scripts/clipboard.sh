#!/usr/bin/env bash 

cliphist list | rofi -dmenu -p "" -display-columns 2 -theme-str 'window {width: 50%;}' -theme-str 'listview {lines: 10;}' | cliphist decode | wl-copy