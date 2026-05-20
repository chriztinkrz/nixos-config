local center_cursor = require("scripts.center_cursor")

local function toggle_special_warp()
    hl.dispatch(hl.dsp.workspace.toggle_special("magic"))
    local win = hl.get_active_window()
    if win then
        center_cursor(win)
    end
end

return toggle_special_warp
