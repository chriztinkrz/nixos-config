local function focus_workspace_boundary(position)
    local current_ws = hl.get_active_workspace()
    if not current_ws then return end
    local ws_id = current_ws.id

    local all_windows = hl.get_windows()
    local ws_windows = {}

    for _, win in ipairs(all_windows) do
        if win and win.workspace and win.workspace.id == ws_id then
            table.insert(ws_windows, win)
        end
    end

    if #ws_windows == 0 then return end

    table.sort(ws_windows, function(a, b)
        local ax = (a.at and a.at.x) or 0
        local bx = (b.at and b.at.x) or 0
        return ax < bx
    end)

    local target_win
    if position == "first" then
        target_win = ws_windows[1]           -- left-most window
    elseif position == "last" then
        target_win = ws_windows[#ws_windows] -- right-most window
    end

    if target_win then
        hl.dispatch(hl.dsp.focus({ window = target_win }))
    end
end
return focus_workspace_boundary
