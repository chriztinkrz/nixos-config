-- window rules --
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})
hl.window_rule({
    name = "scratchpad-stay-focused",
    match = { workspace = "special:magic" },
    stay_focused = true,
})
hl.window_rule({
    name = "foot-opacity",
    match = { class = "foot" },
    opacity = "0.6 override 0.6 override 0.6 override",
})
hl.window_rule({
    name = "zed-opacity",
    match = { class = "dev.zed.Zed" },
    opacity = "0.75 override 0.75 override 0.75 override",
})
hl.window_rule({
    name = "nautilus-opacity",
    match = { class = "org.gnome.Nautilus" },
    opacity = "0.78 override 0.78 override 0.78 override",
})
hl.window_rule({
    name = "nautilus-width",
    match = { class = "org.gnome.Nautilus" },
    scrolling_width = 0.1675,
})
hl.window_rule({
    name = "steam-width",
    match = { class = "steam" },
    scrolling_width = 0.5,
})

-- layer rules --
hl.layer_rule({
    match = { namespace = "rofi" },
    dim_around = true,
})
hl.layer_rule({
    match = { namespace = "^(quickshell:expose)$" },
    dim_around = true,
})
hl.layer_rule({
    match   = { namespace = "wayfreeze" },
    no_anim = true,
})
hl.layer_rule({
    name = "vicinae-blur",
    match = { namespace = "vicinae" },
    blur = true,
    ignore_alpha = 0,
})
hl.layer_rule({
    match = { namespace = "logout_dialog" },
    blur  = true,
})
hl.layer_rule({
    match   = { namespace = "logout_dialog" },
    no_anim = true,
})
hl.layer_rule({
    match      = { namespace = "vicinae" },
    dim_around = true,
})
hl.layer_rule({
    match = { namespace = "logout_dialog" },
    ignore_alpha = 0.5,
})
