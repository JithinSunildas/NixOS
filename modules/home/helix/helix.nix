# ~/.config/nix-config/programs/helix.nix (The Corrected Module)

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ~/nix-config/modules/home/helix/live.toml;

in {
  programs.helix.enable = true;
  stylix.targets.helix.enable = true;
  
  home.file = {
    ".config/helix/config.toml" = {
      source = editableConfigFile;
      type = "link"; 
    };
  };
}
