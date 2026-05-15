local function focus_workspace_boundary(position)
    -- 1. Grab current active workspace ID natively
    local current_ws = hl.get_active_workspace()
    if not current_ws then return end
    local ws_id = current_ws.id

    -- 2. Query all available window layout trees
    local all_windows = hl.get_windows()
    local ws_windows = {}

    -- Filter windows down to just the ones on the current workspace
    for _, win in ipairs(all_windows) do
        if win and win.workspace and win.workspace.id == ws_id then
            table.insert(ws_windows, win)
        end
    end

    -- If the desktop workspace is empty, do nothing
    if #ws_windows == 0 then return end

    -- 3. Sort windows Left-to-Right by their X coordinate (.at.x)
    table.sort(ws_windows, function(a, b)
        local ax = (a.at and a.at.x) or 0
        local bx = (b.at and b.at.x) or 0
        return ax < bx
    end)

    -- 4. Grab target window boundary item based on chosen position arg
    local target_win
    if position == "first" then
        target_win = ws_windows[1]           -- Left-most window
    elseif position == "last" then
        target_win = ws_windows[#ws_windows] -- Right-most window
    end

    -- 5. Focus the target window object directly
    if target_win then
        hl.dispatch(hl.dsp.focus({ window = target_win }))
    end
end
return focus_workspace_boundary
