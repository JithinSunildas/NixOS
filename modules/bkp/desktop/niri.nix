{ config, pkgs, inputs, ... }:

{
  programs.niri = {
    enable = true;
    settings = {
      # Niri settings go here. Check the Niri manual for all options.
      default-layout = "row";
      binds = {
        mod = "Mod4";
        binds = {
          "Mod4-Return" = "spawn alacritty";
          "Mod4-w" = "spawn firefox"; # Replace with your browser
          "Mod4-d" = "spawn fuzzel";
          "Mod4-Shift-c" = "close";
          "Mod4-r" = "reload";
        };
      };
    };
  };
}
