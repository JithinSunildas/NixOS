# modules/home/helix/helix.nix 

{ config, pkgs, lib, ... }:

let
  editableConfigFile = ./live.toml;
in {
  programs.helix.enable = true;

  home.file.".config/helix/config.toml".source = ./live.toml;  

}
