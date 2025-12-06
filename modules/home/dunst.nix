{ config, pkgs, lib, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        width = 300;
        height = 150;
        notification_limit = 5;
        offset = "10x10";
        origin = "top-right";
        transparency = 10;
        padding = 15;
        horizontal_padding = 15;
        frame_width = 2;
        corner_radius = 10;
      };
    };
  };
}
