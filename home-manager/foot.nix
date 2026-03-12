{ config, pkgs, ... }:

{
  home.packages = [ pkgs.foot ];

  xdg.configFile."foot/foot.ini".text = ''
  
  [main]
  include=~/.cache/hellwal/foot-colors.ini
  font=Hermit:size=13.5
  [cursor]
  style=beam

  '';
}