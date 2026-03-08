{
  description = "flake config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
      };
    };

  };

  outputs = { self, nixpkgs, silentSDDM, nix-flatpak, zen-browser, home-manager, ... }@inputs: {
    nixosConfigurations.nixosbtw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # This passes inputs to configuration.nix
      modules = [
        ./configs/system.nix
        nix-flatpak.nixosModules.nix-flatpak
        inputs.silentSDDM.nixosModules.default

        # home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.chriz = import ./configs/zen.nix;
        }
      ];
    };
  };
}