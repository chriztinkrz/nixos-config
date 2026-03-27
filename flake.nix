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
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, silentSDDM, nix-flatpak, zen-browser, home-manager, mac-style-plymouth, ... }@inputs: {  
    nixosConfigurations.nixosbtw = nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configs/system.nix
        ./configs/hardware.nix
        ./configs/elitebook.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.silentSDDM.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ]; }

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.chriz = import ./home-manager/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
    nixosConfigurations.vostro = nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configs/system.nix
        ./configs/hardware_vostro.nix
        ./configs/vostro.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.silentSDDM.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ]; }

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.chriz = import ./home-manager/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
    nixosConfigurations.common = nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configs/system.nix
        ./configs/hardware.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.silentSDDM.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ]; }

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.chriz = import ./home-manager/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}