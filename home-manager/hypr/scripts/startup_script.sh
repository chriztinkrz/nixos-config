#!/usr/bin/env bash
hyprlock &
sleep 1
waybar &
vicinae server &
awww-daemon &
awww img "$HOME/.cache/current_wallpaper.png" --transition-type grow --transition-duration 1.75 &
wait
