{ config, pkgs, ... }:
{
  boot.kernelModules = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
}
