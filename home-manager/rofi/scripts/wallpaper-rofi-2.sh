#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Pictures/wallpapers"
THUMB_DIR="$HOME/.cache/wallthumbs"
CACHE_FILE="$HOME/.cache/wall_rofi_list.txt"
LOCK_FILE="/tmp/wall_gen.lock"
mkdir -p "$THUMB_DIR"
ORDER_FILE="$HOME/.cache/wall_order.txt"

generate_list() {
    if [ -f "$LOCK_FILE" ]; then return; fi
    touch "$LOCK_FILE"

    local tmp_cache="${CACHE_FILE}.tmp"

    # 1. Find all current wallpapers on disk
    find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -printf "%T@ %f\n" | \
    sort -k1,1n -k2,2 | cut -d' ' -f2- > /tmp/wall_current.txt

    # 2. Create order file if it doesn't exist
    touch "$ORDER_FILE"

    # 3. Remove entries from order file that no longer exist on disk
    tmp_order="${ORDER_FILE}.tmp"
    while read -r name; do
        [ -f "$WALL_DIR/$name" ] && echo "$name"
    done < "$ORDER_FILE" > "$tmp_order"
    cat "$tmp_order" > "$ORDER_FILE" && rm "$tmp_order"

    # 4. Append new wallpapers (not in order file) sorted oldest->newest
    while read -r name; do
        if ! grep -qxF "$name" "$ORDER_FILE"; then
            echo "$name" >> "$ORDER_FILE"
        fi
    done < /tmp/wall_current.txt

    rm /tmp/wall_current.txt

    # 5. Build cache from order file
    while read -r name; do
        full_path="$WALL_DIR/$name"
        hash=$(cksum <<< "$full_path" | cut -f1 -d' ')
        thumb="$THUMB_DIR/$hash.jpg"

        echo "$name|$thumb"

        if [ ! -f "$thumb" ]; then
            magick "$full_path" -thumbnail 300x300^ -gravity center -extent 300x300 "$thumb" >/dev/null 2>&1
        fi
    done < "$ORDER_FILE" > "$tmp_cache"

    cat "$tmp_cache" > "$CACHE_FILE" && rm "$tmp_cache"
    rm "$LOCK_FILE"
}

# --- 2. INITIAL CHECK ---
if [ ! -f "$CACHE_FILE" ]; then
    generate_list
fi

# --- 2.5. PRUNE DELETED ENTRIES ---
if [ -f "$CACHE_FILE" ] && [ -f "$ORDER_FILE" ]; then
    tmp_cache="${CACHE_FILE}.tmp"
    > "$tmp_cache"
    tmp_order=$(mktemp)

    while IFS='|' read -r name thumb; do
        if [ -f "$WALL_DIR/$name" ]; then
            echo "$name" >> "$tmp_order"
            echo "$name|$thumb" >> "$tmp_cache"
        else
            [ -f "$thumb" ] && rm -f "$thumb"
        fi
    done < "$CACHE_FILE"

    # Write through the symlink, don't replace it
    cat "$tmp_order" > "$ORDER_FILE"
    rm "$tmp_order"

    mv "$tmp_cache" "$CACHE_FILE"
fi

# --- 3. LAUNCH ROFI ---
last_row=$(($(wc -l < "$CACHE_FILE") - 1))
chosen=$(awk -F'|' '{printf "%s\0icon\x1f%s\n", $1, $2}' "$CACHE_FILE" | \
    rofi -dmenu -i \
    -selected-row "$last_row" \
    -show-icons \
    -kb-move-char-back 'Ctrl+Z'\
    -kb-move-char-forward 'Ctrl+X' \
    -kb-row-up 'Left' \
    -kb-row-down 'Right' \
    -theme-str '
    window {
    width: 88%;
    location: south;
    anchor: south;
    margin: 10px;
}
    listview {
    lines: 1;
    columns: 10;
    fixed-height: true;
}
    element {
    orientation: vertical;
    children: [ element-icon ];
}
    element-icon {
    size: 175px;
    horizontal-align: 0.5;
}
    element-text {
    enabled: false;
}
    inputbar {
    enabled: false;
}

')

# --- 4. EXECUTE SELECTION ---
if [ -n "$chosen" ]; then
    full="$WALL_DIR/$chosen"
    ln -sf "$full" "$HOME/.cache/current_wallpaper.png"
    awww img "$full" --transition-type grow --transition-duration 1.65 &
    (
        hellwal -i "$full"

        # zed reload
        cat "$HOME/.cache/hellwal/zed.json" > "$HOME/.config/zed/settings.json"
        touch "$HOME/.config/zed/settings.json"

        # 3. terminal things, for tty-clock
        if [ -f "$HOME/.cache/hellwal/terminal.sh" ]; then
            sh "$HOME/.cache/hellwal/terminal.sh" > /dev/tty
        fi

        pkill -USR1 cava
        pkill -USR2 btop
        makoctl reload
        pkill -USR2 waybar

        sleep 0.15

        # final terminal thing
        if [ -f "$HOME/.cache/hellwal/terminal.sh" ]; then
            for tty in /dev/pts/[0-9]*; do
                sh "$HOME/.cache/hellwal/terminal.sh" > "$tty" 2>/dev/null &
            done
        fi
    ) &
fi

# --- 5. BACKGROUND REFRESH ---
generate_list &
