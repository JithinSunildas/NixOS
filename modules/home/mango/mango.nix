{ config, ... }:

{
  programs.mango.enable = true;
  
  xdg.configFile."mango/config.conf".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/mango/config.conf";
}
