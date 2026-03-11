{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/niri/config.kdl";

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        terminal = "foot"; # or your preferred terminal
      };
      colors = {
        background = "1a1b26ff"; # Tokyo Night Dark background
        text = "c0caf5ff";
        match = "bb9af7ff";
        selection = "33467bff";
        selection-text = "c0caf5ff";
        border = "bb9af7ff";
      };
    };
  };
}
