#!/usr/bin/env bash
hyprlock &
sleep 1
waybar &
vicinae server &
awww-daemon &
wait
