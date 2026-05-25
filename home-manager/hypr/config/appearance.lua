hl.config({
    group = {
        ["col.border_active"]   = color7,
        ["col.border_inactive"] = color3,
        groupbar = {
            font_family               = "Zalando Sans Expanded",
            font_size                 = 17,
            height                    = 22,
            ["col.active"]            = color3,
            ["col.inactive"]          = color1,
            text_color                = color7,
            blur                      = true,
            gradients                 = true,
            keep_upper_gap            = false,
            gradient_rounding         = true,
            gradient_round_only_edges = false,
        },
    },
})
hl.config({
    general = {
        gaps_in     = 6,
        gaps_out    = {
            top     = 0,
            right   = 12,
            bottom  = 12,
            left    = 12,
        },
        border_size = 4,
        col                 = {
            active_border   = color7,
            inactive_border = color3,
        },
        resize_on_border = false,
        allow_tearing    = false,
    },
})
hl.config({
    decoration = {
        rounding           = 7,
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
            enabled = true,
            xray = true,
            size = 2,
            passes = 2,
            ignore_opacity = true,
            vibrancy = 0.1696,
            popups = true,
        },
    },
})
