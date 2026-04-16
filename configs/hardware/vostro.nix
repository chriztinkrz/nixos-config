{ config, pkgs, lib, ... }:
{
# vostro 5471 fixes
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  boot.initrd.kernelModules = [ "i915" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  boot.kernelParams = [
    "i915.enable_psr=0"
    ];
  boot.blacklistedKernelModules = [ "amdgpu" "radeon" ];
  programs.nh.clean.extraArgs = lib.mkForce "--keep 35";
}
