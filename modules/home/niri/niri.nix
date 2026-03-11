{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/niri/config.kdl";

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Libre Baskerville:size=10";
        terminal = "foot"; 
      };
      colors = {
          background = "0f0f0fff";     
          text = "d1d1d1ff";           
          match = "ffffffff";          
          selection = "2a2a2aff";      
          selection-text = "ffffffff"; 
          border = "333333ff";         
        };
    };
  };
}
