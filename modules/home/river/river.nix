{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    river-classic
    stacktile   # binary dwindle layout (replaces rivertile)
    swayidle
  ];

  xdg.configFile."river/init" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/modules/home/river/init";
    # river requires the init script to be executable
    executable = true;
  };
}
