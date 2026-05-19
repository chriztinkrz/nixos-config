local function move_window_retain_width(target)
    local win = hl.get_active_window()
    if not win or not win.workspace then return end

    local source_ws = win.workspace.id
    local target_ws

    -- Determine if target is relative ("+1"/"-1") or an absolute number
    if type(target) == "string" and (target:sub(1,1) == "+" or target:sub(1,1) == "-") then
        local delta = tonumber(target) or 0
        target_ws = source_ws + delta
    else
        target_ws = tonumber(target)
    end

    -- Safety boundary check
    if not target_ws or target_ws < 1 then target_ws = 1 end

    local monitor = hl.get_monitor(win.monitor)
    local screen_width = monitor and monitor.size and monitor.size.x or 1920
    local scale = monitor and monitor.scale or 1

    local gaps_out_left  = 34
    local gaps_out_right = 34
    local gaps_in        = 0
    local border_size    = 4

    -- Calculate fraction exactly as you had it
    local outer = gaps_out_left + gaps_out_right
    local per_window_overhead = (gaps_in * 2) + (border_size * 2)
    local usable = (screen_width / scale) - outer - per_window_overhead

    local col_fraction = win.size.x / usable

    if col_fraction > 0.98 then col_fraction = 1.0 end
    if col_fraction < 0.1  then col_fraction = 0.1 end

    -- Move the window to the target workspace
    hl.dispatch(hl.dsp.window.move({ workspace = target_ws, window = win, follow = true }))

    -- Delay execution to let Hyprland register the workspace migration
    hl.timer(function()
        hl.dispatch(hl.dsp.focus({ window = win }))
        hl.dispatch(hl.dsp.layout("colresize " .. string.format("%.4f", col_fraction)))
    end, { timeout = 20, type = "oneshot" })
end

return move_window_retain_width
