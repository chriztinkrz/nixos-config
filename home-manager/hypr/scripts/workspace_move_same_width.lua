local function move_window_retain_width(direction)
    local win = hl.get_active_window()
    if not win or not win.workspace then return end

    local source_ws = win.workspace.id
    local target_ws = (direction == "+1") and (source_ws + 1) or (source_ws - 1)
    if target_ws < 1 then target_ws = 1 end

    local monitor = hl.get_monitor(win.monitor)
    local screen_width = monitor and monitor.size and monitor.size.x or 1920
    local scale = monitor and monitor.scale or 1

    local gaps_out_left  = 16.25
    local gaps_out_right = 16.25
    local gaps_in        = 7
    local border_size    = 4

    -- total width taken by outer gaps
    local outer = gaps_out_left + gaps_out_right
    -- each window in a column has gaps_in on each side + border on each side
    local per_window_overhead = (gaps_in * 2) + (border_size * 2)
    local usable = (screen_width / scale) - outer - per_window_overhead

    local col_fraction = win.size.x / usable

    if col_fraction > 0.98 then col_fraction = 1.0 end
    if col_fraction < 0.1  then col_fraction = 0.1  end

    hl.dispatch(hl.dsp.window.move({ workspace = target_ws, window = win, follow = true }))

    hl.timer(function()
        hl.dispatch(hl.dsp.focus({ window = win }))
        hl.dispatch(hl.dsp.layout("colresize " .. string.format("%.4f", col_fraction)))
    end, { timeout = 20, type = "oneshot" })
end

return move_window_retain_width
