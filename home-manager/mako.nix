{ config, pkgs, ... }:

{
  home.packages = [ pkgs.mako ];

  xdg.configFile."mako/config".text = ''
border-radius=8
font=Inter Regular 13 @‍wght=200
width=375
default-timeout=5000
ignore-timeout=1
include=~/.config/mako/mako-colors

  '';
}