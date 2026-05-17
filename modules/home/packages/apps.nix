{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # Browsers
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Office & Productivity
    cheese
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
    strawberry
    gifski
    imv
    kdePackages.kdenlive

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
