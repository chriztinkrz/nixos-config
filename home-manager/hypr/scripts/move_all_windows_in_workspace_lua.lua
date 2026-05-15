local function move_all_windows_to_workspace(target_input)
    -- 1. Get current workspace object natively
    local source_ws = hl.get_active_workspace()
    if not source_ws then return end
    local source_id = source_ws.id

    -- 2. Handle Relative Logic (+1 / -1) or Explicit Numbers
    local target_id
    if target_input == "+1" then
        target_id = source_id + 1
    elseif target_input == "-1" then
        target_id = source_id - 1
    else
        target_id = tonumber(target_input)
    end

    -- Enforce minimum workspace rule boundary
    if not target_id or target_id < 1 then
        target_id = 1
    end

    -- 3. Get windows matching current workspace ID
    local all_windows = hl.get_windows()
    local target_windows = {}

    for _, win in ipairs(all_windows) do
        -- Ensure the window object is valid and matches our workspace
        if win and win.workspace and win.workspace.id == source_id then
            table.insert(target_windows, win)
        end
    end

    -- 4. Sort Left-to-Right based on the X coordinate (.at.x)
    table.sort(target_windows, function(a, b)
        local ax = (a.at and a.at.x) or 0
        local bx = (b.at and b.at.x) or 0
        return ax < bx
    end)

    -- 5. Move them sequentially to preserve the relative stacking layout
    for _, win in ipairs(target_windows) do
        hl.dispatch(hl.dsp.window.move({
            workspace = target_id,
            window = win,
            silent = true
        }))
    end

    -- 6. Follow the move by focusing the target workspace
    hl.dispatch(hl.dsp.focus({ workspace = target_id }))
end
return move_all_windows_to_workspace
