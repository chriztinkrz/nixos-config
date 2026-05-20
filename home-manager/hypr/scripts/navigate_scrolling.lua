local function navigate_scrolling(direction)
    local current_ws = hl.get_active_workspace()
    if not current_ws then return end
    local ws_id = current_ws.id

    local all_windows = hl.get_windows()
    local ws_windows = {}

    for _, win in ipairs(all_windows) do
        if win and win.workspace and win.workspace.id == ws_id and not win.floating then
            table.insert(ws_windows, win)
        end
    end

    if #ws_windows <= 1 then return end

    table.sort(ws_windows, function(a, b)
        local ax = (a.at and a.at.x) or 0
        local bx = (b.at and b.at.x) or 0
        return ax < bx
    end)

    local active_win = hl.get_active_window()
    local current_idx = nil
    for i, win in ipairs(ws_windows) do
        if active_win and win.address == active_win.address then
            current_idx = i
            break
        end
    end

    if not current_idx then
        hl.dispatch(hl.dsp.focus({ window = ws_windows[1] }))
        return
    end

    local target_idx
    if direction == "left" then
        target_idx = current_idx - 1
    elseif direction == "right" then
        target_idx = current_idx + 1
    end

    if target_idx and ws_windows[target_idx] then
        local target_win = ws_windows[target_idx]
        hl.dispatch(hl.dsp.focus({ window = target_win }))
    end
end

return navigate_scrolling
