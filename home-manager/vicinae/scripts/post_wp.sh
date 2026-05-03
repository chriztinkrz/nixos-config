#!/usr/bin/env bash

vicinae theme set hellwal
pkill -USR1 cava
pkill -USR2 btop
makoctl reload
pkill -USR2 waybar

# zed reload
cat "$HOME/.cache/hellwal/zed.json" > "$HOME/.config/zed/settings.json"
touch "$HOME/.config/zed/settings.json"

# 3. terminal things, for tty-clock
if [ -f "$HOME/.cache/hellwal/terminal.sh" ]; then
    sh "$HOME/.cache/hellwal/terminal.sh" > /dev/tty
fi

sleep 0.15

# final terminal thing
if [ -f "$HOME/.cache/hellwal/terminal.sh" ]; then
    for tty in /dev/pts/[0-9]*; do
        sh "$HOME/.cache/hellwal/terminal.sh" > "$tty" 2>/dev/null &
    fi

    sleep 0.15
