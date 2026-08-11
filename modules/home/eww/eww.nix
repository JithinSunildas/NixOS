{ config, ... }:

{
  xdg.configFile."eww".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/eww";
}
