local home = os.getenv("HOME")
dofile(home .. "/.cache/hellwal/hyprland.lua")
package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"
return home
