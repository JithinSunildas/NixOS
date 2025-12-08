# modules/home/helix/helix.nix 

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ./live.toml;
in {
  programs.helix.enable = true;
  stylix.targets.helix.enable = true;
  
  home.sessionVariables = {
    HELIX_CONFIG = "${config.home.homeDirectory}/.config/helix"; 
  };
}
