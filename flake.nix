{
  description = "flake config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

  };

  outputs = { self, nixpkgs, silentSDDM, nix-flatpak, ... }@inputs: {
    nixosConfigurations.nixosbtw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # This passes inputs to configuration.nix
      modules = [
        ./configuration.nix
        nix-flatpak.nixosModules.nix-flatpak
      ];
    };
  };
}