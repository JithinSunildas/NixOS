# ~/.config/nix-config/programs/helix.nix (The Corrected Module)

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ./live.toml;

in {
  programs.helix.enable = true;
  stylix.targets.helix.enable = true;
  
  home.file = {
    "/home/tikhaboom/.config/helix/config.toml" = {
      source = editableConfigFile;
      type = "link"; 
    };
  };
}
