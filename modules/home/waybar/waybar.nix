{ config, ...}:

{
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/home/tikhaboom/nix-config/modules/home/waybar";
}
