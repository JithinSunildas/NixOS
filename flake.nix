{
  description = "NixOS in SuperDuperComputer!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
          url = "github:0xc000022070/zen-browser-flake";
          # Make sure it follows your main nixpkgs input for compatibility
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      ...
    }:
    {
      nixosConfigurations = {
        SuperDuperComputer = nixpkgs.lib.nixosSystem {

          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tikhaboom = import ./modules/home/home.nix;
            }
          ];
        };
      };

    };
}
