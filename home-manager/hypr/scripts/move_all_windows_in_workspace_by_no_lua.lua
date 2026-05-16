local function move_all_windows_to_workspace(target_input)
    local source_ws = hl.get_active_workspace()
    if not source_ws then return end
    local source_id = source_ws.id

    local target_id
    if target_input == "+1" then
        target_id = source_id + 1
    elseif target_input == "-1" then
        target_id = source_id - 1
    else
        target_id = tonumber(target_input)
    end

    if not target_id or target_id < 1 then
        target_id = 1
    end

    if source_id == target_id then return end

    local all_windows = hl.get_windows()
    local target_windows = {}

    for _, win in ipairs(all_windows) do
        if win and win.workspace and win.workspace.id == source_id then
            table.insert(target_windows, win)
        end
    end

    table.sort(target_windows, function(a, b)
        local ax = (a.at and a.at.x) or 0
        local bx = (b.at and b.at.x) or 0
        return ax < bx
    end)

    -- Robust sequential loop to avoid layout breaking
    local index = 1
    local function process_next_window()
        if index > #target_windows then
            hl.dispatch(hl.dsp.focus({ workspace = target_id }))
            return
        end

        local win = target_windows[index]
        hl.dispatch(hl.dsp.window.move({
            workspace = target_id,
            window = win,
            silent = true
        }))

        index = index + 1
        hl.timer(process_next_window, { timeout = 40, type = "oneshot" })
    end

    if #target_windows > 0 then
        process_next_window()
    else
        hl.dispatch(hl.dsp.focus({ workspace = target_id }))
    end
end

return move_all_windows_to_workspace_by_no
