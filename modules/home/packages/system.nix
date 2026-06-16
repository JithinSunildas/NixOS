{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    efibootmgr
    unzip
    zstd
    file
    slurp
    satty
    cyme
    parted
    xxd
    nix-ld
    xhost
    ninja
    pkg-config
    notify
    imagemagick
    ventoy-full
    ffmpegthumbnailer
    tesseract5
    grim
    unar
    kanshi
    wl-mirror
    jq
    poppler-utils
    # inputs.gazelle.packages.${pkgs.system}.default
    psmisc

    # File management
    yazi

    # System monitoring/management
    gparted
    gnome-disk-utility
    nautilus
  ];
}
