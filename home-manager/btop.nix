{ config, pkgs, ... }:

{
xdg.configFile."btop/themes/hellwal.theme".source = 
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/hellwal/btop.theme";
}