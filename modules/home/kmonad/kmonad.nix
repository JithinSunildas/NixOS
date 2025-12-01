{ config, pkgs, lib, ... }:

{
  home.file.".config/kmonad/config.kbd".source = ./config.kbd;
}
