{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    efibootmgr
    unzip
    parted
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
