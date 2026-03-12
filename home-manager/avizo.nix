{ config, pkgs, ... }: {
  xdg.configFile."avizo/config.ini".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/hellwal/avizo.ini";
}