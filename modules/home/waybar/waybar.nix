{ config, pkgs, lib, ... }:

{
  home.file.".config/waybar/config".source = ./waybar.conf;
  home.file.".config/waybar/style.css".source = ./waybar.css;
}
