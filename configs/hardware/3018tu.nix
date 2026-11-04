{ inputs, pkgs, config, lib, ... }: {
  networking.networkmanager.wifi.powersave = false;
  boot.blacklistedKernelModules = [ "rtw88_8821ce" "rtw88_pci" ];

  # Pin to kernel 6.18
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_18;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    ((pkgs.callPackage "${inputs.nixpkgs-2605}/pkgs/os-specific/linux/rtl8821ce" {
      kernel = config.boot.kernelPackages.kernel;
      kernelModuleMakeFlags = [];
    }).overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        # Create missing module signing certificate expected by NixOS build hook
        find $out -name "8821ce.ko*" -exec touch {}.cer \;
      '';
    }))
  ];

  boot.kernelModules = [ "8821ce" ];
}
