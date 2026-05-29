{ config, ... }:

{
  xdg.configFile."mango/config.kdl".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/mango/config.conf";
}
