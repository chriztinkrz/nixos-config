{ inputs, pkgs, config, lib, ... }: {
  networking.networkmanager.wifi.powersave = false;
  boot.blacklistedKernelModules = [ "rtw88_8821ce" "rtw88_pci" ];
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_18;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    (callPackage "${inputs.nixpkgs-2605}/pkgs/os-specific/linux/rtl8821ce" {})
  ];
  boot.kernelModules = [ "8821ce" ];
}
