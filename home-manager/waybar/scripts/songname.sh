#!/bin/bash

# This stays open and waits for the player to tell IT what changed
playerctl metadata --format '{{status}} {{title}}' --follow 2>/dev/null | while read -r line; do
    # Simple bash string replacement for ampersands (no sed/pipes needed!)
    clean_line="${line//&/&amp;}"
    echo "$clean_line"
done || echo "Empty"