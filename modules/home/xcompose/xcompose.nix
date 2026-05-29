{ config, pkgs, ... }:

{
  home.file.".XCompose" = {
    source = ./dot-xcompose;
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "xim";
    QT_IM_MODULE = "xim";
    XMODIFIERS = "@im=none";

    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    
    GDK_BACKEND = "wayland";
    };
}
