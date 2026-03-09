{ config, pkgs, ... }:

{
  home.packages = [ pkgs.foot ];

  xdg.configFile."foot/foot.ini".text = ''
  
  [main]
  include=~/.config/foot/themes/matugen.ini
  font=Hermit:size=13.5
  [cursor]
  style=beam

  '';
}