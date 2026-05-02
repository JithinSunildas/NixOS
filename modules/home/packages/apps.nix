{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # Browsers
    chromium
    qutebrowser
    firefox
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Office & Productivity
    cheese
    obsidian
    zathura
    gnome-calculator

    # Communication
    telegram-desktop
    discord

    # Media
    mpv
    xclip
    python313Packages.subliminal
    obs-studio
    rhythmbox
    gifski
    imv

    # Downloads
    qbittorrent
  ];

  # === Tweaks & Configs ===

  programs = {
    zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
  };
}
