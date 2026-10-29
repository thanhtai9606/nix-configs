{
  description = "NixOS flake for nemo (laptop + desktop)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mkHost = hostProfile: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs hostProfile;
      };
      modules = [
        ./nixos/machines/${hostProfile}.nix
      ];
    };
  in {
    formatter.x86_64-linux = pkgs.alejandra;

    nixosConfigurations = {
      laptop = mkHost "laptop";
      desktop = mkHost "desktop";
      # Alias for older deploy commands targeting `nemo`.
      nemo = self.nixosConfigurations.laptop;
    };

    homeConfigurations.nemo = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs;
        hostProfile = "laptop";
      };
      modules = [
        ./home-manager
      ];
    };
  };
}
