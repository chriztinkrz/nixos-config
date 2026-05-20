local home = os.getenv("HOME")
dofile(home .. "/.cache/hellwal/hyprland.lua")
package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"

-- scripts (share window_widths via closure by defining it here)
local window_widths = {}
local move_retain,  track_resize          = require("scripts.workspace_move_same_width")
local move_all                            = require("scripts.move_all_windows_in_workspace_lua")
local focus_first_and_last                = require("scripts.focus_first_and_last")
local capture_youtube_music               = require("scripts.ytm_scratchpad_lua-2")
local toggle_focus_tile_floating          = require("scripts.focus_floating")
local navigate                            = require("scripts.navigate_scrolling")
local zoom                                = require("scripts.zoom")
local center_cursor                       = require("scripts.center_cursor")
local toggle_magic_scratchpad             = require("scripts.toggle_special_warp")

-- config sections
local setup_binds = require("config.binds")
dofile(home .. "/.config/hypr/config/monitors.lua")
dofile(home .. "/.config/hypr/config/autostart.lua")
dofile(home .. "/.config/hypr/config/env.lua")
dofile(home .. "/.config/hypr/config/layouts.lua")
dofile(home .. "/.config/hypr/config/appearance.lua")
dofile(home .. "/.config/hypr/config/animations.lua")
dofile(home .. "/.config/hypr/config/input.lua")
dofile(home .. "/.config/hypr/config/rules.lua")
dofile(home .. "/.config/hypr/config/misc.lua")

hl.on("window.open", center_cursor)
hl.on("hyprland.start", function() capture_youtube_music() end)

setup_binds({
    navigate              = navigate,
    focus_first_and_last  = focus_first_and_last,
    move_retain           = move_retain,
    window_widths         = window_widths,
    move_all              = move_all,
    toggle_focus          = toggle_focus_tile_floating,
    toggle_magic_scratchpad = toggle_magic_scratchpad,
    zoom                  = zoom,
})
