-- local home = os.getenv("HOME")
-- dofile(home .. "/.cache/hellwal/hyprland.lua")

-- require("~/.cache/hellwal/hyprland.lua")
-- require("/etc/hypr/plugins.conf")

-- hyprland.lua - converted from hyprland.conf
-- Refer to https://wiki.hypr.land/Configuring/Start/

-- Source theme colors (hellwal generates this)
-- NOTE: hl.source() may not exist yet; if not, inline your colors or use dofile()
-- hl.source("~/.cache/hellwal/hyprland.lua") -- update path/extension as needed
-- hl.source("/etc/hypr/plugins.conf")         -- same here

-- Colors from hellwal are referenced as $color1, $color7 etc. in the original.
-- You'll need to define them here or load them from hellwal's lua output.
-- Example (replace with actual hellwal lua output):
-- local colors = require("~/.cache/hellwal/colors") -- adjust as needed
-- For now, placeholders matching the variable names:
-- local color1 = "0xff000000" -- replace with actual hellwal output
-- local color3 = "0xff000000"
-- local color7 = "0xffffffff"


------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 0.83,
})
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
    mirror   = "eDP-1",
})
-- hl.monitor({
--     output   = "HDMI-A-1",
--     mode     = "3840x2160@60",
--     position = "3840x0",
--     scale    = 1.5,
-- })


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/startup_script.sh")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("avizo-service")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("quickshell -p ~/.config/hypr/qs-hyprview/shell.qml")
    hl.exec_cmd("~/nixos-config/home-manager/hypr/scripts/wrap_cursor_new_window.sh")
    hl.exec_cmd("~/.config/hypr/scripts/ytm_scratchpad.sh")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "40")
hl.env("HYPRCURSOR_SIZE", "40")
hl.env("HYPRCURSOR_THEME", "ComixCursors-Opaque-Black")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Layout settings
hl.config({
    scrolling = {
        column_width             = 0.3333,
        explicit_column_widths   = "0.3333, 0.5, 0.667",
        follow_min_visible       = 0.15,
        direction                = "right",
        fullscreen_on_one_column = false,
        wrap_focus               = false,
        wrap_swapcol             = false,
    },
})

hl.config({
    master = {
        new_status                    = "inherit",
        orientation                   = "center",
        slave_count_for_center_master = 0,
        mfact                         = 0.33333,
    },
})

--[[ hy3 plugin config
hl.config({
    plugin = {
        hy3 = {
            tabs = {
                text_font             = "Zalando Sans Expanded",
                text_height           = 12,
                ["col.active"]        = color1,
                ["col.active.border"] = color7,
                ["col.active.text"]   = color7,
                ["col.inactive"]      = color3,
                ["col.inactive.text"] = color7,
                opacity               = 0.7,
                radius                = 7,
            },
            autotile = {
                enable         = true,
                trigger_width  = 575,
                trigger_height = 400,
            },
        },
    },
}) ]]

hl.config({
    group = {
        ["col.border_active"]   = color7,
        ["col.border_inactive"] = color3,
        groupbar                = {
            font_family      = "Zalando Sans Expanded",
            font_size        = 17,
            height           = 22,
            ["col.active"]   = color7,
            ["col.inactive"] = color3,
            text_color       = color7,
            blur             = true,
        },
    },
})

hl.config({
    general = {
        gaps_in          = 9,
        gaps_out         = {
            top    = 13,
            right  = 18,
            bottom = 18,
            left   = 18
        },

        border_size      = 4,

        col              = {
            active_border   = color7,
            inactive_border = color1,
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout           = "scrolling",
    },
})

hl.config({
    decoration = {
        rounding           = 6,
        rounding_power     = 13,
        fullscreen_opacity = 1.0,
        dim_modal          = true,
        dim_special        = 0.3,

        shadow             = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur               = {
            enabled        = true,
            xray           = true,
            size           = 2,
            passes         = 2,
            ignore_opacity = true,
            vibrancy       = 0.1696,
            popups         = true,
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

-- Bezier curves
hl.curve("wind", { type = "bezier", points = { { 0.2, 0.6 }, { 0.1, 1.05 } } })
hl.curve("wind2", { type = "bezier", points = { { 0.05, 1.1 }, { 0.1, 1.5 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.0175 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })
hl.curve("workspace", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1.0175 } } })
hl.curve("winClose", { type = "bezier", points = { { 0.8, 1 }, { 0.9, 1.05 } } })
hl.curve("spring_anim", { type = "bezier", points = { { 0.45, 1.25 }, { 0.45, 1.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1.03 } } })

-- Animations
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 10, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 17, bezier = "wind", style = "popins" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 9, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 9, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 10, bezier = "workspace", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 12, bezier = "workspace" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "",
        kb_rules      = "",

        follow_mouse  = 1,
        sensitivity   = -0.275,
        accel_profile = "flat",

        touchpad      = {
            natural_scroll = true,
            scroll_factor  = 0.4,
        },
    },
})

hl.device({
    name        = "syna30b0:00-06cb:ce08-2",
    sensitivity = 0.7,
})
hl.device({
    name        = "msft0001:00-06cb:7e7e-touchpad",
    sensitivity = 0.6,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Rofi
hl.bind(mainMod .. " + GRAVE", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper-rofi-2.sh"))

-- Vicinae
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("vicinae vicinae://launch/system/browse-apps"))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + SHIFT + GRAVE", hl.dsp.exec_cmd("vicinae vicinae://extensions/sovereign/awww-switcher/wprandom"))
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd("vicinae vicinae://extensions/rastsislaux/pulseaudio/outputDevices"))
hl.bind("ALT + CTRL + SHIFT + S", hl.dsp.exec_cmd("vicinae vicinae://extensions/rastsislaux/pulseaudio/playback"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("vicinae vicinae://extensions/Gelei/bluetooth/devices"))
hl.bind(mainMod .. " + CTRL + SHIFT + B", hl.dsp.exec_cmd("vicinae vicinae://extensions/Gelei/bluetooth/scan"))
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd("vicinae vicinae://launch/files/search"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))

-- Misc binds
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("makoctl dismiss -a"))
hl.bind(mainMod .. " + F5",
    hl.dsp.exec_cmd(
        "gpu-screen-recorder -w screen -f 60 -fm cfr -k h264 -c mp4 -a $(pactl get-default-sink).monitor -o ~/Videos/gpu-screen-recorder/$(date +%d.%m.%Y_%I:%M%p).mp4 & notify-send 'recording started'"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("pkill -INT -f gpu-screen-recorder && notify-send 'recording stopped'"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout"))

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-beta"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus --new-window"))
hl.bind("ALT + SHIFT + W", hl.dsp.exec_cmd("~/nixos-config/home-manager/hypr/scripts/toggle_waybar.sh"))

-- Focus window
hl.bind("ALT + A", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + D", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + W", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + S", hl.dsp.focus({ direction = "down" }))
-- hl.bind("ALT + Tab", hl.dsp.focus({ target = "currentorlast" }))

-- Focus first/last window in workspace (raw dispatch for complex inline shell)
hl.bind(mainMod .. " + A",
    hl.dsp.exec_cmd(
        "hyprctl dispatch focuswindow address:$(hyprctl clients -j | jq -r '[.[] | select(.workspace.id == '$(hyprctl activeworkspace -j | jq .id)') ] | sort_by(.at[0]) | first | .address')"))
hl.bind(mainMod .. " + D",
    hl.dsp.exec_cmd(
        "hyprctl dispatch focuswindow address:$(hyprctl clients -j | jq -r '[.[] | select(.workspace.id == '$(hyprctl activeworkspace -j | jq .id)') ] | sort_by(.at[0]) | last | .address')"))

-- Switch workspace by number
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Switch workspaces relatively
hl.bind(mainMod .. " + W", hl.dsp.focus({ workspace = "r-1" }), { repeating = true })
hl.bind(mainMod .. " + S", hl.dsp.focus({ workspace = "r+1" }), { repeating = true })
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + Z", hl.dsp.focus({ workspace = "empty" }))

-- Scroll through workspaces with super + mouse scroll
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r+1" }), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r-1" }), { mouse = true })

-- Move window to workspace
for i = 1, 10 do
    local key = i % 10
    hl.bind("CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "empty" }))

-- Move all windows to workspace
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + CTRL + SHIFT + " .. key,
        hl.dsp.exec_cmd(".config/hypr/scripts/move_all_windows_in_workspace.sh " .. i))
end
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(".config/hypr/scripts/move_all_windows_in_workspace.sh -1"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(".config/hypr/scripts/move_all_windows_in_workspace.sh +1"))

-- Move window
hl.bind("CTRL + SHIFT + A", hl.dsp.layout("swapcol l"))
hl.bind("CTRL + SHIFT + D", hl.dsp.layout("swapcol r"))
hl.bind("CTRL + SHIFT + W", hl.dsp.window.move({ direction = "up" }))
hl.bind("CTRL + SHIFT + S", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + SHIFT + Q", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + SHIFT + W", hl.dsp.window.move({ direction = "right" }))

-- Layout controls
hl.bind(mainMod .. " + CTRL + X", hl.dsp.layout("fit visible"))
hl.bind(mainMod .. " + CTRL + Z", hl.dsp.layout("fit all"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.layout("fit tobeg"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.layout("fit toend"))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(".config/hypr/scripts/toggle_layout.sh"))
hl.bind("ALT + GRAVE",
    hl.dsp.exec_cmd("quickshell ipc -p ~/.config/hypr/qs-hyprview/shell.qml call expose toggle justified"))
hl.bind("CTRL + SHIFT + Z", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("hyprctl dispatch togglegroup"))
hl.bind(mainMod .. " + CTRL + SHIFT + A", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive f"))
hl.bind(mainMod .. " + CTRL + SHIFT + D", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive b"))

-- Resize window (scrolling layout)
hl.bind(mainMod .. " + CTRL + SHIFT + Z", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + CTRL + D", hl.dsp.layout("colresize +0.03"), { repeating = true })
hl.bind(mainMod .. " + CTRL + A", hl.dsp.layout("colresize -0.03"), { repeating = true })
hl.bind(mainMod .. " + CTRL + SHIFT + X", hl.dsp.layout("fit active"))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scratchpad
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd(".config/hypr/scripts/warp_cursor_scratchpad.sh"))
hl.bind(mainMod .. " + ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Audio and brightness
hl.bind("ALT + F2", hl.dsp.exec_cmd("volumectl -u up"), { repeating = true })
hl.bind("ALT + F1", hl.dsp.exec_cmd("volumectl -u down"), { repeating = true })
hl.bind("ALT + F3", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("F2", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("F1", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("F3", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("SHIFT + F2", hl.dsp.exec_cmd("lightctl up"), { repeating = true })
hl.bind("SHIFT + F1", hl.dsp.exec_cmd("lightctl down"), { repeating = true })

-- Laptop keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volumectl -u up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volumectl -u down"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("lightctl up"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl down"), { repeating = true })

-- Zoom (mouse)
hl.bind(mainMod .. " + SHIFT + mouse_down",
    hl.dsp.exec_cmd(
        "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {v = $2 * 1.1; print (v > 3 ? 3 : v)}')"),
    { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse_up",
    hl.dsp.exec_cmd(
        "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {v = $2 * 0.9; print (v < 1 ? 1 : v)}')"),
    { mouse = true })

-- Zoom (keyboard)
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind(mainMod .. " + F2",
    hl.dsp.exec_cmd(
        "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {v = $2 * 1.1; print (v > 3 ? 3 : v)}')"),
    { repeating = true })
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1.75"))

-- Screenshots
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("hypr-screenshot output"))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("hypr-screenshot region"))
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("hypr-screenshot window"))

-- hy3 plugin binds
hl.bind("ALT + SHIFT + X", hl.dsp.exec_cmd("hyprctl dispatch hy3:makegroup v"))
hl.bind("ALT + SHIFT + C", hl.dsp.exec_cmd("hyprctl dispatch hy3:makegroup h"))
hl.bind("ALT + CTRL + SHIFT + X", hl.dsp.exec_cmd("hyprctl dispatch hy3:changefocus raise"))
hl.bind("ALT + SHIFT + A", hl.dsp.exec_cmd("hyprctl dispatch hy3:movewindow l"))
hl.bind("ALT + SHIFT + D", hl.dsp.exec_cmd("hyprctl dispatch hy3:movewindow r"))
hl.bind("ALT + SHIFT + W", hl.dsp.exec_cmd("hyprctl dispatch hy3:makegroup tab toggle"))
hl.bind("ALT + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch hy3:focustab l"))
hl.bind("ALT + SHIFT + E", hl.dsp.exec_cmd("hyprctl dispatch hy3:focustab r"))
hl.bind("ALT + SHIFT + CTRL + D", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 30 0"), { repeating = true })
hl.bind("ALT + SHIFT + CTRL + A", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -30 0"), { repeating = true })
hl.bind("ALT + SHIFT + CTRL + W", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 30"), { repeating = true })
hl.bind("ALT + SHIFT + CTRL + S", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -30"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl dispatch hy3:togglefocuslayer"))
hl.bind("ALT + SHIFT + Z", hl.dsp.exec_cmd("hyprctl dispatch hy3:expand expand"))
hl.bind("ALT + CTRL + SHIFT + Z", hl.dsp.exec_cmd("hyprctl dispatch hy3:expand shrink"))
hl.bind("ALT + SHIFT + V", hl.dsp.exec_cmd("hyprctl dispatch hy3:equalize workspace"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name         = "scratchpad-stay-focused",
    match        = { workspace = "special:magic" },
    stay_focused = true,
})

hl.window_rule({
    name    = "foot-opacity",
    match   = { class = "foot" },
    opacity = "0.6 override 0.6 override 0.6 override"
})

hl.window_rule({
    name    = "zed-opacity",
    match   = { class = "dev.zed.Zed" },
    opacity = "0.75 override 0.75 override 0.75 override"
})

hl.window_rule({
    name    = "nautilus-opacity",
    match   = { class = "org.gnome.Nautilus" },
    opacity = "0.78 override 0.78 override 0.78 override"
})

-- Layer rules
hl.layer_rule({ match = { namespace = "rofi" }, dim_around = true })
hl.layer_rule({ match = { namespace = "^(quickshell:expose)$" }, dim_around = true })
hl.layer_rule({ match = { namespace = "wayfreeze" }, no_anim = true })
hl.layer_rule({
    name         = "vicinae-blur",
    match        = { namespace = "vicinae" },
    blur         = true,
    ignore_alpha = 0,
})
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({ match = { namespace = "logout_dialog" }, no_anim = true })
hl.layer_rule({ match = { namespace = "vicinae" }, dim_around = true })
hl.layer_rule({ match = { namespace = "logout_dialog" }, ignore_alpha = 0.5 })


--------------
---- MISC ----
--------------

hl.config({
    misc = {
        focus_on_activate        = true,
        animate_manual_resizes   = true,
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = false,
        disable_splash_rendering = true,
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.config({
    binds = {
        scroll_event_delay = 0,
    },
})

hl.config({
    cursor = {
        zoom_rigid               = true,
        zoom_detached_camera     = false,
        persistent_warps         = true,
        warp_on_change_workspace = true,
    },
})
