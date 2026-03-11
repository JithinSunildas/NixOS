{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home/niri/config.kdl";

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Libre Baskerville:size=12";
        terminal = "foot"; 
      };
    };
    colors = {
        background = "0f0f0fff";     # Deep black-gray
        text = "d1d1d1ff";           # Soft white/light gray
        match = "ffffffff";          # Pure white for matched characters (pop)
        selection = "2a2a2aff";      # Subtle dark gray for selection
        selection-text = "ffffffff"; # White text when selected
        border = "333333ff";         # Dark gray border
      };
  };
}
