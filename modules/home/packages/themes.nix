{ pkgs, ... }:
{
  home.packages = with pkgs; [

    # Icon themes
    candy-icons
    reversal-icon-theme

    # Fonts
    nerd-fonts.iosevka-term-slab
    nerd-fonts.iosevka
  ];
}
