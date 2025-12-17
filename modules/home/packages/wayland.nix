{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Window management
    eww
    wofi
    fuzzel
    waybar
    
    # Notifications & OSD
    swaynotificationcenter
    swayosd
    dunst
    
    # Wallpaper & Theming
    swww
    waypaper
    nwg-look
    
    # Lock screen
    swaylock
    
    # Media control
    waybar-mpris
    playerctl
    
    # Keyboard management
    keyd
    kmonad
  ];
}
