{ config, pkgs, ... }:

{
  home.packages = [ pkgs.btop ];

  # 1. THE MAIN CONFIG FILE
  xdg.configFile."btop/btop.conf".text = ''
    #? Config file for btop v.1.4.6
    
    # Point to the theme managed by Matugen
    color_theme = "${config.home.homeDirectory}/.config/btop/themes/matugen.theme"
    
    theme_background = true
    truecolor = true
    force_tty = false
    presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty"
    vim_keys = false
    rounded_corners = true
    graph_symbol = "braille"
    shown_boxes = "cpu mem net proc"
    update_ms = 2100
    proc_sorting = "cpu lazy"
    proc_colors = true
    proc_gradient = true
    proc_mem_bytes = true
    proc_cpu_graphs = true
    check_temp = true
    cpu_sensor = "Auto"
    show_uptime = true
    show_cpu_watts = true
    clock_format = "%X"
    
    # Keep this False so btop doesn't overwrite your Nix-managed config
    save_config_on_exit = false 
  '';

  # 2. THE THEME TEMPLATE (For Matugen)
  # If you are using the Matugen method we discussed, 
  # map your template into the btop themes folder:
  xdg.configFile."btop/themes/matugen.theme".source = ./matugen.theme;
}