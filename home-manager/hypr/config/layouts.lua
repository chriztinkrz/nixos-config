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
hl.config({
    general = {
        layout = "scrolling"
    }
})
