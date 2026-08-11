{ config, pkgs, ... }:

{
  home.file.".XCompose" = {
    source = ./dot-xcompose;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    
    GDK_BACKEND = "wayland";
    };
}
