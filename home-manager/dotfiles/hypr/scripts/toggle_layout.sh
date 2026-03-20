#!/usr/bin/env bash

CURRENT=$(hyprctl getoption general:layout | awk '/str:/ {print $2}')

if [ "$CURRENT" = "scrolling" ]; then
    NEW_LAYOUT="dwindle"
else
    NEW_LAYOUT="scrolling"
fi

hyprctl keyword general:layout "$NEW_LAYOUT"
notify-send "$NEW_LAYOUT"