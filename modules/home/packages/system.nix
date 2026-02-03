{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    efibootmgr
    unzip
    cyme
    parted
    xxd
    xhost
    ninja
    niriswitcher
    pkg-config
    imagemagick
    ffmpegthumbnailer
    unar
    jq
    poppler-utils

    # File management
    yazi

    # System monitoring/management
    gparted
    gnome-disk-utility
    nautilus
  ];
}
