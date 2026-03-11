{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/niri/config.kdl";
}
