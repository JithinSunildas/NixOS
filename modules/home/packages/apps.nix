{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # Browsers
    chromium
    firefox
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    
    # Office & Productivity
    libreoffice
    obsidian
    gnome-calculator
    kdePackages.okular
    
    # Communication
    telegram-desktop
    discord
    
    # Media
    mpv
    obs-studio
    gifski
    imv 
    
    # Downloads
    qbittorrent
  ];
}
