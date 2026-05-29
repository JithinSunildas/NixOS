{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    river-classic
    swayidle 
  ];

  xdg.configFile."river/init".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/river/init";
}
