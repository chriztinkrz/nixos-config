local home = os.getenv("HOME")
dofile(home .. "/.cache/hellwal/hyprland.lua")
package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"

-- scripts
local window_widths             = {}
local move_retain, track_resize = require("scripts.workspace_move_same_width")
local move_all                  = require("scripts.move_all_windows_in_workspace_lua")
local focus_first_and_last      = require("scripts.focus_first_and_last")
local capture_youtube_music     = require("scripts.ytm_scratchpad_lua-2")
local toggle_focus              = require("scripts.focus_floating")
local navigate                  = require("scripts.navigate_scrolling")
local zoom                      = require("scripts.zoom")
local center_cursor             = require("scripts.center_cursor")
local toggle_magic_scratchpad   = require("scripts.toggle_special_warp")
local setup_binds               = require("config.binds")

-- config sections
require("config.monitors")
require("config.autostart")
require("config.env")
require("config.layouts")
require("config.appearance")
require("config.animations")
require("config.input")
require("config.rules")
require("config.misc")

-- events
hl.on("window.open", center_cursor)
hl.on("hyprland.start", function() capture_youtube_music() end)

-- binds
setup_binds({
    navigate                = navigate,
    focus_first_and_last    = focus_first_and_last,
    move_retain             = move_retain,
    window_widths           = window_widths,
    move_all                = move_all,
    toggle_focus            = toggle_focus,
    toggle_magic_scratchpad = toggle_magic_scratchpad,
    zoom                    = zoom,
})
