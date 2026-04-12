{ config, pkgs, ... }:
{
  boot.kernelModules = [ "amdgpu" ];
}
