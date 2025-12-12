{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    unzip
    xhost
    ninja
    pkg-config
    imagemagick
    ffmpegthumbnailer 
    unar             
    jq               
    poppler-utils    
    fd               
    ripgrep          
    fzf              
    zoxide           
    
    # File management
    yazi
    
    # System monitoring/management
    gparted
    gnome-disk-utility
    nautilus
  ];
}
