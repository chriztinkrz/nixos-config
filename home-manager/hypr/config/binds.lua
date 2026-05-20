local function setup_binds(deps)
    local navigate               = deps.navigate
    local focus_first_and_last   = deps.focus_first_and_last
    local move_retain            = deps.move_retain
    local window_widths          = deps.window_widths
    local move_all               = deps.move_all
    local toggle_focus           = deps.toggle_focus
    local toggle_magic_scratchpad = deps.toggle_magic_scratchpad
    local zoom                   = deps.zoom

    -- rofi
    hl.bind("SUPER + GRAVE", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper-rofi-2.sh"))

    -- vicinae
    hl.bind("SUPER + SPACE",          hl.dsp.exec_cmd("vicinae vicinae://launch/system/browse-apps"))
    hl.bind("SUPER + ALT + SPACE",    hl.dsp.exec_cmd("vicinae toggle"))
    hl.bind("SUPER + SHIFT + GRAVE",  hl.dsp.exec_cmd("vicinae vicinae://launch/@sovereign/store.vicinae.awww-switcher/wprandom"))
    hl.bind("CTRL + ALT + S",         hl.dsp.exec_cmd("vicinae vicinae://launch/@rastsislaux/store.vicinae.pulseaudio/outputDevices"))
    hl.bind("SUPER + SHIFT + B",      hl.dsp.exec_cmd("vicinae vicinae://launch/@Gelei/store.vicinae.bluetooth/devices"))
    hl.bind("SUPER + CTRL + SHIFT + B", hl.dsp.exec_cmd("vicinae vicinae://extensions/Gelei/bluetooth/scan"))
    hl.bind("SUPER + ALT + E",        hl.dsp.exec_cmd("vicinae vicinae://launch/files/search"))
    hl.bind("SUPER + V",              hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))
    hl.bind("SUPER + SHIFT + V",      hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))

    -- miscellaneous
    hl.bind("SUPER + L",      hl.dsp.exec_cmd("hyprlock"))
    hl.bind("SUPER + N",      hl.dsp.exec_cmd("makoctl dismiss -a"))
    hl.bind("SUPER + F5",     hl.dsp.exec_cmd("gpu-screen-recorder -w screen -f 60 -fm cfr -k h264 -c mp4 -a $(pactl get-default-sink).monitor -o ~/Videos/gpu-screen-recorder/$(date +%d.%m.%Y_%I:%M%p).mp4 & notify-send 'recording started'"))
    hl.bind("SUPER + F4",     hl.dsp.exec_cmd("pkill -INT -f gpu-screen-recorder && notify-send 'recording stopped'"))
    hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("wlogout"))

    -- apps
    hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("foot"))
    hl.bind("SUPER + B",      hl.dsp.exec_cmd("zen-beta"))
    hl.bind("SUPER + E",      hl.dsp.exec_cmd("nautilus --new-window"))

    -- focus l/r/alt tab/toggle float & tile/ last & first
    hl.bind("ALT + A",        hl.dsp.focus({ direction = "left" }))
    hl.bind("ALT + D",        hl.dsp.focus({ direction = "right" }))
    hl.bind("ALT + W",        hl.dsp.focus({ direction = "up" }))
    hl.bind("ALT + S",        hl.dsp.focus({ direction = "down" }))
    hl.bind("ALT + TAB",      hl.dsp.focus({ last = true }))
    hl.bind("SUPER + SHIFT + T", toggle_focus)
    hl.bind("SUPER + A", function() focus_first_and_last("first") end)
    hl.bind("SUPER + D", function() focus_first_and_last("last") end)

    -- ws switch by no.
    for i = 1, 10 do
        local key = i % 10
        hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    end

    -- relative ws switch
    hl.bind("SUPER + W",   hl.dsp.focus({ workspace = "r-1" }), { repeating = true })
    hl.bind("SUPER + S",   hl.dsp.focus({ workspace = "r+1" }), { repeating = true })
    hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "previous" }))
    hl.bind("SUPER + Z",   hl.dsp.focus({ workspace = "empty" }))
    hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "r+1" }), { mouse = true })
    hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "r-1" }), { mouse = true })

    -- move window to ws
    for i = 1, 10 do
        local key = i % 10
        hl.bind("CTRL + SHIFT + " .. key, function() move_retain(i, window_widths) end)
    end
    hl.bind("SUPER + SHIFT + W", function() move_retain("-1", window_widths) end)
    hl.bind("SUPER + SHIFT + S", function() move_retain("+1", window_widths) end)
    hl.bind("SUPER + SHIFT + Z", hl.dsp.window.move({ workspace = "empty" }))

    -- move window to ws relatively
    hl.bind("SUPER + ALT + W", function() move_all("-1") end)
    hl.bind("SUPER + ALT + S", function() move_all("+1") end)

    -- move all windows to ws
    for i = 1, 9 do
        hl.bind("SUPER + CTRL + SHIFT + " .. i, function() move_all(i) end)
    end
    hl.bind("SUPER + CTRL + SHIFT + 0", function() move_all(10) end)

    -- move window
    hl.bind("CTRL + SHIFT + A",         hl.dsp.layout("swapcol l"))
    hl.bind("CTRL + SHIFT + D",         hl.dsp.layout("swapcol r"))
    hl.bind("CTRL + SHIFT + W",         hl.dsp.window.move({ direction = "up" }))
    hl.bind("CTRL + SHIFT + S",         hl.dsp.window.move({ direction = "down" }))
    hl.bind("SUPER + CTRL + SHIFT + Q", hl.dsp.window.move({ direction = "left" }))
    hl.bind("SUPER + CTRL + SHIFT + W", hl.dsp.window.move({ direction = "right" }))

    -- layout controls
    hl.bind("SUPER + CTRL + X", hl.dsp.layout("fit visible"))
    hl.bind("SUPER + CTRL + Z", hl.dsp.layout("fit all"))
    hl.bind("SUPER + CTRL + Q", hl.dsp.layout("fit tobeg"))
    hl.bind("SUPER + CTRL + W", hl.dsp.layout("fit toend"))
    hl.bind("SUPER + T",        hl.dsp.window.float({ action = "toggle" }))
    hl.bind("SUPER + F",        hl.dsp.window.fullscreen({ mode = 0 }))
    hl.bind("ALT + GRAVE",      hl.dsp.exec_cmd("quickshell ipc -p ~/.config/hypr/qs-hyprview/shell.qml call expose toggle justified"))
    hl.bind("CTRL + SHIFT + Z", hl.dsp.window.close())

    -- group
    hl.bind("ALT+SHIFT+W",       hl.dsp.group.toggle({ window }))
    hl.bind("ALT+SHIFT+E",       hl.dsp.group.next({ window }))
    hl.bind("ALT+SHIFT+Q",       hl.dsp.group.prev({ window }))
    hl.bind("ALT+SHIFT+D",       hl.dsp.window.move({ direction = "r", group_aware = true }))
    hl.bind("ALT+SHIFT+A",       hl.dsp.window.move({ direction = "l", group_aware = true }))
    hl.bind("ALT+CTRL+SHIFT+A",  hl.dsp.group.move_window({ backward }))
    hl.bind("ALT+CTRL+SHIFT+D",  hl.dsp.group.move_window({ forward }))

    -- scrolling resize
    hl.bind("SUPER + CTRL + SHIFT + Z", hl.dsp.layout("colresize +conf"))
    hl.bind("SUPER + CTRL + SHIFT + X", hl.dsp.layout("fit active"))
    hl.bind("SUPER + CTRL + D",         hl.dsp.layout("colresize +0.03"), { repeating = true })
    hl.bind("SUPER + CTRL + A",         hl.dsp.layout("colresize -0.03"), { repeating = true })

    -- scrolling resize but mouse

    hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- scratchpad
    hl.bind("ALT + SHIFT + S",         toggle_magic_scratchpad)
    hl.bind("SUPER + ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

    -- bright / loud
    hl.bind("ALT + F2",   hl.dsp.exec_cmd("volumectl -u up"),                            { repeating = true, locked = true })
    hl.bind("ALT + F1",   hl.dsp.exec_cmd("volumectl -u down"),                          { repeating = true, locked = true })
    hl.bind("ALT + F3",   hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
    hl.bind("F2",         hl.dsp.exec_cmd("playerctl play-pause"),                       { locked = true })
    hl.bind("F1",         hl.dsp.exec_cmd("playerctl previous"),                         { locked = true })
    hl.bind("F3",         hl.dsp.exec_cmd("playerctl next"),                             { locked = true })
    hl.bind("SHIFT + F2", hl.dsp.exec_cmd("lightctl up"),                                { repeating = true, locked = true })
    hl.bind("SHIFT + F1", hl.dsp.exec_cmd("lightctl down"),                              { repeating = true, locked = true })

    -- laptop bright / loud
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("volumectl -u up"),   { repeating = true })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("volumectl -u down"), { repeating = true })
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("lightctl up"),       { repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl down"),     { repeating = true })

    -- zoom kb
    hl.bind("SUPER + F2", function() zoom.zoom_in()    end, { repeating = true })
    hl.bind("SUPER + F1", function() zoom.zoom_out()   end, { repeating = true })
    hl.bind("SUPER + F3", function() zoom.zoom_reset() end, { repeating = true })

    -- zoom mouse
    hl.bind("SUPER + SHIFT + mouse_down",  function() zoom.zoom_in()    end, { repeating = true })
    hl.bind("SUPER + SHIFT + mouse_up",    function() zoom.zoom_out()   end, { repeating = true })
    hl.bind("SUPER + SHIFT + mouse:272",   function() zoom.zoom_reset() end, { repeating = true })

    -- screenshot
    hl.bind("SUPER + F8", hl.dsp.exec_cmd("hypr-screenshot output"))
    hl.bind("SUPER + F7", hl.dsp.exec_cmd("hypr-screenshot region"))
    hl.bind("SUPER + F6", hl.dsp.exec_cmd("hypr-screenshot window"))
end

return setup_binds
