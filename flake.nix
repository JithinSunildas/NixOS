# flake.nix
{
  description = "NixOS in SuperDuperComputer!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gazelle.url = "github:Zeus-Deus/gazelle-tui";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, gazelle, zen-browser, stylix
    , spicetify-nix, ... }: {
      nixosConfigurations = {
        SuperDuperComputer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        tikhaboom = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };

          modules = [
            ./modules/home/home.nix
            stylix.homeModules.stylix
            spicetify-nix.homeManagerModules.default
            gazelle.homeModules.gazelle
          ];

          extraSpecialArgs = { inherit inputs spicetify-nix; };
        };
      };
    };
}
