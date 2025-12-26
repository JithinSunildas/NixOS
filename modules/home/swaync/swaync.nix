# modules/home/swaync/swaync.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile = {
    "swaync/config.json".source = ./config.json;
    "swaync/style.css".source = ./style.css;
  };
}
