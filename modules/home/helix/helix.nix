# ~/.config/nix-config/programs/helix.nix (Final FIX)

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ./live.toml;
in {
  programs.helix.enable = true;
  stylix.targets.helix.enable = true;
  
  home.file = {
    "**.config/helix/config.toml**" = {
      source = editableConfigFile;
      type = "link"; 
    };
  };

  home.sessionVariables = {
    HELIX_CONFIG = "${config.home.homeDirectory}/.config/helix"; 
  };
}
