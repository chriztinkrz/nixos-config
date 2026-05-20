local function center_cursor_on_window(win)
    if win and win.at and win.size then
        local center_x = math.floor(win.at.x + (win.size.x / 2))
        local center_y = math.floor(win.at.y + (win.size.y / 2))
        hl.dispatch(hl.dsp.cursor.move({ x = center_x, y = center_y }))
    end
end

return center_cursor_on_window
