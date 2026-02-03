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
    pkg-config
    notify
    imagemagick
    ffmpegthumbnailer
    tesseract5
    grim
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
