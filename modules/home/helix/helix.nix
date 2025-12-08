# ~/.config/nix-config/programs/helix.nix (The Corrected Module)

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ./live.toml;

in {
  programs.helix.enable = true;
  stylix.targets.helix.enable = true;
  
  home.file = {
    "**helix/config.toml" = {
      source = editableConfigFile;
      type = "link"; 
    };
  };

  home.sessionVariables = {
    HELIX_CONFIG = "${config.home.homeDirectory}/.config/helix"; 
  };
}
