#!/usr/bin/env bash

sh -c 'for i in {1..120}; do \
    ADDRESS=$(hyprctl clients -j | jq -r ".[] | select(.title | contains(\"YouTube Music\")) | .address"); \
    if [ -n "$ADDRESS" ]; then \
        hyprctl dispatch movetoworkspacesilent special:magic,address:$ADDRESS; \
        hyprctl dispatch togglefloating address:$ADDRESS; \
        hyprctl dispatch resizewindowpixel exact 700 1000,address:$ADDRESS; \
        break; \
    fi; \
    sleep 1; \
  done'