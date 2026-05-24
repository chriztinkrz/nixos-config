 { config, pkgs, lib, ... }:
{
  /* boot = {
    kernelModules = [ "amdgpu" ];
    plymouth.enable = lib.mkForce false;
    kernelParams = lib.mkForce [
      "boot.shell_on_fail"
      "loglevel=4"
      "rd.systemd.show_status=true"
      "rd.udev.log_level=3"
    ];
    consoleLogLevel = lib.mkForce 4;
    }; */
}
