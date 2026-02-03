{ config, pkgs, ... }:

{
  home.file.".XCompose" = {
    source = ./dot-xcompose;
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "xim";
    QT_IM_MODULE = "xim";
    XMODIFIERS = "@im=none";
  };
}
