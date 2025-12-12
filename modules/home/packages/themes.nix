{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # GTK themes
    adw-gtk3
    
    # Icon themes
    papirus-icon-theme
    candy-icons
    reversal-icon-theme
  ];
}
