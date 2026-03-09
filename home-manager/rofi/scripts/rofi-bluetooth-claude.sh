#!/usr/bin/env bash
#
# Simple Bluetooth connection menu using rofi

# Full path to bluetoothctl (in case it's not in PATH)
BT_CTL=$(command -v bluetoothctl)

# Check if bluetoothctl exists
if [ ! -x "$BT_CTL" ]; then
    echo "bluetoothctl not found" | rofi -dmenu -p "" -theme-str 'window { width: 17.5%; }' -theme-str 'listview {lines: 2;}'
    exit 1
fi

# Function to run bluetoothctl commands
bt_cmd() {
    echo "$@" | $BT_CTL
}

# Get power status
power_status=$(bt_cmd "show" | grep "Powered:" | awk '{print $2}')

if [ "$power_status" != "yes" ]; then
    # If powered off, show option to power on
    choice=$(echo -e "Power On Bluetooth\nExit" | rofi -dmenu -p "" -theme-str 'window { width: 17.5%; }' -theme-str 'listview {lines: 2;}')
    
    case "$choice" in
        "Power On Bluetooth")
            # Check if rfkill is blocking
            if rfkill list bluetooth 2>/dev/null | grep -q 'blocked: yes'; then
                rfkill unblock bluetooth
                sleep 1
            fi
            bt_cmd "power on"
            sleep 1
            # Re-run script after powering on
            exec "$0"
            ;;
    esac
    exit 0
fi

# Get paired devices - try both commands
paired_devices=$(bt_cmd "devices Paired" 2>/dev/null)
if [ -z "$paired_devices" ] || echo "$paired_devices" | grep -q "Missing"; then
    paired_devices=$(bt_cmd "paired-devices" 2>/dev/null)
fi

# Filter out only Device lines
paired_devices=$(echo "$paired_devices" | grep "^Device")

if [ -z "$paired_devices" ]; then
    choice=$(echo -e "No paired devices\n---\nPower Off Bluetooth" | rofi -dmenu -p "" -theme-str 'window { width: 17.5%; }' -theme-str 'listview {lines: 2;}')
    if [ "$choice" = "Power Off Bluetooth" ]; then
        bt_cmd "power off"
    fi
    exit 0
fi

# Build menu with device names and connection status
menu=""
declare -A device_map

while IFS= read -r line; do
    if [ -z "$line" ]; then
        continue
    fi
    
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d ' ' -f 3-)
    
    # Check if connected
    conn_status=$(bt_cmd "info $mac" | grep "Connected:" | awk '{print $2}')
    
    if [ "$conn_status" = "yes" ]; then
        status="✓"
    else
        status="○"
    fi
    
    menu_item="$status $name"
    menu+="$menu_item\n"
    device_map["$menu_item"]="$mac"
done <<< "$paired_devices"

# Add separator and power off option
menu+="---\nPower Off Bluetooth"

# Show menu
chosen=$(echo -e "$menu" | rofi -dmenu -p "" -theme-str 'window { width: 17.5%; }' -theme-str 'listview {lines: 2;}')

# Handle choice
if [ -z "$chosen" ]; then
    exit 0
fi

if [ "$chosen" = "Power Off Bluetooth" ]; then
    bt_cmd "power off"
    exit 0
fi

if [ "$chosen" = "---" ]; then
    exit 0
fi

# Get MAC address for chosen device
mac="${device_map[$chosen]}"

if [ -n "$mac" ]; then
    # Toggle connection
    conn_status=$(bt_cmd "info $mac" | grep "Connected:" | awk '{print $2}')
    
    if [ "$conn_status" = "yes" ]; then
        bt_cmd "disconnect $mac"
        notify-send "Bluetooth" "Disconnected from ${chosen#* }"
    else
        bt_cmd "connect $mac"
        notify-send "Bluetooth" "Connecting to ${chosen#* }..."
    fi
fi
