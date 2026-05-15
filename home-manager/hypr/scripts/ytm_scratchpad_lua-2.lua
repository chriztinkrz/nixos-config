local attempts = 0
local max_attempts = 120

local function capture_youtube_music()
    local windows = hl.get_windows()
    local target_win = nil

    for _, win in ipairs(windows) do
        if win.title and string.find(win.title, "YouTube Music") then
            target_win = win
            break
        end
    end

    if target_win then
        hl.dispatch(hl.dsp.window.move({
            workspace = "special:magic",
            window = target_win,
            follow = false
        }))

        hl.dispatch(hl.dsp.window.float({ action = "toggle", window = target_win }))

        hl.timer(function()
            hl.dispatch(hl.dsp.window.resize({
                x = 700,
                y = 1000,
                relative = false,
                window = target_win
            }))

            hl.dispatch(hl.dsp.window.center({ window = target_win }))
        end, { timeout = 20, type = "oneshot" })

        return
    end

    attempts = attempts + 1
    if attempts < max_attempts then
        hl.timer(capture_youtube_music, { timeout = 1000, type = "oneshot" })
    end
end

capture_youtube_music()

return capture_youtube_music
