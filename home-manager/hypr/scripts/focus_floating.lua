local function toggle_focus_tile_floating()
    local win = hl.get_active_window()
    if not win then return end

    if win.floating then
        -- If currently on a floating window, focus a tiled window
        hl.dispatch(hl.dsp.focus({ window = "tiled" }))
    else
        -- If currently on a tiled window, focus a floating window
        hl.dispatch(hl.dsp.focus({ window = "floating" }))
    end
end

return toggle_focus_tile_floating
