hl.config({
    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "",
        kb_rules      = "",
        repeat_rate   = 50,
        follow_mouse  = 1,
        sensitivity   = -0.275,
        accel_profile = "flat",
        touchpad      = { natural_scroll = true, scroll_factor = 0.4 },
    },
})
hl.device({ name = "syna30b0:00-06cb:ce08-2",       sensitivity = 0.7 })
hl.device({ name = "msft0001:00-06cb:7e7e-touchpad", sensitivity = 0.6 })
hl.gesture({ fingers = 3, direction = "vertical",  action = "workspace" })
--[[ hl.gesture({ fingers = 2, direction = "pinchin",   action = "cursorZoom", zoom_level = 1.25, mode = "mult" })
hl.gesture({ fingers = 2, direction = "pinch",     action = "cursorZoom", zoom_level = 1,    mode = "live" }) ]]
