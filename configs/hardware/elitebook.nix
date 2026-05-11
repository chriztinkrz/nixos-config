 { config, pkgs, lib, ... }:
{
  boot = {
    kernelModules = [ "amdgpu" ];
    plymouth.enable = lib.mkForce false;
    kernelParams = [];
    consoleLogLevel = lib.mkForce 4;
  };
}
