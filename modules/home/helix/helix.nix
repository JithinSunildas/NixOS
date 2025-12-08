# ~/.config/nix-config/programs/helix.nix

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ./live.toml; 

in {
  programs.helix = {
    enable = true;
    
    extraPackages = [
      (pkgs.writeText "helix-symlink-install" ''
        ln -sf ${editableConfigFile} $out/.config/helix/config.toml
      '')
    ];

    extraFiles = {
      "live.toml".source = editableConfigFile;
    };
  };
}
