#!/usr/bin/env bash
for i in $(seq 1 120); do
    ADDRESS=$(hyprctl clients -j | jq -r '.[] | select(.title | contains("YouTube Music")) | .address')
    if [ -n "$ADDRESS" ]; then
        hyprctl dispatch "hl.dsp.window.move({ workspace = 'special:magic', window = 'address:$ADDRESS', silent = true })"
        hyprctl dispatch "hl.dsp.window.float({ action = 'toggle', window = 'address:$ADDRESS' })"
        hyprctl dispatch "hl.dsp.window.resize({ x = 700, y = 1000, window = 'address:$ADDRESS' })"
        break
    fi
    sleep 1
done
