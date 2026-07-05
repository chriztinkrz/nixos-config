{ inputs, pkgs, config, ... }: {
  networking.networkmanager.wifi.powersave = false;
  boot.blacklistedKernelModules = [ "rtw88_8821ce" "rtw88_pci" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8821ce ];
  boot.kernelModules = [ "8821ce" ];
}