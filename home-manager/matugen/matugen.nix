{ config, pkgs, ... }:

{
  home.packages = [ pkgs.matugen ];

  # 1. The Matugen Config File
  xdg.configFile."matugen/config.toml".text = ''
    [config]
    [templates]

    [templates.rofi]
    input_path = "~/.config/matugen/templates/rofi.rasi"
    output_path = "~/.config/rofi/theme.rasi"

    [templates.waybar]
    input_path = "~/.config/matugen/templates/waybar.css"
    output_path = "~/.config/waybar/colors.css"

    [templates.mako]
    input_path = "~/.config/matugen/templates/mako.conf"
    output_path = "~/.config/mako/mako-colors"
    post_hook = 'makoctl reload'

    [templates.niri]
    input_path = "~/.config/matugen/templates/niri.kdl"
    output_path = "~/.config/niri/colors.kdl"

    [templates.foot]
    input_path = "~/.config/matugen/templates/foot.ini"
    output_path = "~/.config/foot/themes/matugen.ini"

    [templates.cava]
    input_path = "~/.config/matugen/templates/cava.ini"
    output_path = "~/.config/cava/themes/matugen"
    post_hook = 'pkill -USR1 cava'

    [templates.avizo]
    input_path = "~/.config/matugen/templates/avizo.ini"
    output_path = "~/.config/avizo/config.ini"

    [templates.hyprlock]
    input_path = "~/.config/matugen/templates/hyprlock.conf"
    output_path = "~/.config/hypr/hyprlock_colors.conf"
    post_hook = 'hyprctl reload'

    [templates.btop]
    input_path = "~/.config/matugen/templates/btop.theme"
    output_path = "~/.config/btop/themes/matugen.theme"
    post_hook = 'pkill -USR2 btop'

    [templates.hyprland]
    input_path = "~/.config/matugen/templates/hyprland.conf"
    output_path = "~/.config/hypr/hyprland_colors.conf"
  '';

  # 2. Mapping the template files
  # This assumes you create a 'templates' folder inside 'hm-configs/matugen/'
  xdg.configFile."matugen/templates/rofi.rasi".source = ./templates/rofi.rasi;
  xdg.configFile."matugen/templates/waybar.css".source = ./templates/waybar.css;
  xdg.configFile."matugen/templates/mako.conf".source = ./templates/mako.conf;
  xdg.configFile."matugen/templates/niri.kdl".source = ./templates/niri.kdl;
  xdg.configFile."matugen/templates/foot.ini".source = ./templates/foot.ini;
  xdg.configFile."matugen/templates/cava.ini".source = ./templates/cava.ini;
  xdg.configFile."matugen/templates/avizo.ini".source = ./templates/avizo.ini;
  xdg.configFile."matugen/templates/hyprlock.conf".source = ./templates/hyprlock.conf;
  xdg.configFile."matugen/templates/btop.theme".source = ./templates/btop.theme;
  xdg.configFile."matugen/templates/hyprland.conf".source = ./templates/hyprland.conf;
}