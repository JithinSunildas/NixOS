{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # Browsers
    chromium
    qutebrowser
    firefox
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Office & Productivity
    libreoffice
    cheese
    obsidian
    zathura
    gnome-calculator

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
