{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    efibootmgr
    unzip
    lsusb
    parted
    xxd
    xhost
    ninja
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
