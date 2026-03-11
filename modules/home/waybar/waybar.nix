{
  config,
  pkgs,
  lib,
  ...
}:

{
  xdg.configFile."waybar/config".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/waybar/waybar.conf";
  home.file.".config/waybar/style.css".source = ./waybar.css;
}
