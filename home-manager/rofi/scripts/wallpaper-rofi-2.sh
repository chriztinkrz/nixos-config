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
    mv "$tmp_order" "$ORDER_FILE"

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

    mv "$tmp_cache" "$CACHE_FILE"
    rm "$LOCK_FILE"
}

# --- 2. INITIAL CHECK ---
if [ ! -f "$CACHE_FILE" ]; then
    generate_list
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
    swww img "$full" --transition-type grow --transition-duration 1.75 &
    (
        ln -sf "$full" "$HOME/.cache/current_wallpaper.png"
        hellwal -i "$full"

        # 1. FIRST PUSH (Instant feedback)
        if [ -f "$HOME/.cache/hellwal/terminal.sh" ]; then
            sh "$HOME/.cache/hellwal/terminal.sh" > /dev/tty
        fi

        # 2. RELOAD HEAVY SERVICES
        pkill -USR1 cava
        pkill -USR2 btop
        makoctl reload
        pkill -USR2 waybar

        # 3. THE "LOCK" DELAY
        # Wait for Waybar to finish its GTK/DBus initialization
        sleep 0.15

        # 4. FINAL PUSH (Broadcast to all terminals to override Waybar's reset)
        if [ -f "$HOME/.cache/hellwal/terminal.sh" ]; then
            sh "$HOME/.cache/hellwal/terminal.sh" > /dev/tty
            for tty in /dev/pts/[0-9]*; do
                sh "$HOME/.cache/hellwal/terminal.sh" > "$tty" 2>/dev/null &
            done
        fi
    ) &
fi

# --- 5. BACKGROUND REFRESH ---
generate_list &