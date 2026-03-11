{ config, pkgs, ... }:

{
  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "/home/tikhaboom/nix-config/modules/home/niri/config.kdl";
}
