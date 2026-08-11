{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # GTK themes
    adw-gtk3

    # Icon themes
    reversal-icon-theme
  ];
}
