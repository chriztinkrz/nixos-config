#!/usr/bin/env bash
if pgrep "waybar" > /dev/null
then
    pkill waybar
    hyprctl keyword general:gaps_out 13 13 13 13
else
    waybar &
    hyprctl keyword general:gaps_out 11 13 13 13
fi
