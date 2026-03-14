{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    efibootmgr
    unzip
    file
    cyme
    parted
    xxd
    xhost
    ninja
    pkg-config
    wifitui
    notify
    imagemagick
    ffmpegthumbnailer
    tesseract5
    grim
    unar
    kanshi
    wl-mirror
    jq
    poppler-utils
    inputs.gazelle.packages.${pkgs.system}.default
    psmisc

    # File management
    yazi

    # System monitoring/management
    gparted
    gnome-disk-utility
    nautilus
  ];
}
