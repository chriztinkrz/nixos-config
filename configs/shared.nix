{ inputs, pkgs, ... }: {

  imports = [
    ./system.nix
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.silentSDDM.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.chriz = import ../home-manager/home.nix;
    backupFileExtension = "backup";
  };

}
