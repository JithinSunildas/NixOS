{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    unzip
    xhost
    ninja
    pkg-config
    imagemagick
    
    # File management
    yazi
    
    # System monitoring/management
    gparted
    gnome-disk-utility
    nautilus
  ];
}
