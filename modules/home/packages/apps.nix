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

    # Media
    mpv
    xclip
    python313Packages.subliminal
    strawberry
    gifski
    imv
    kdePackages.kdenlive
    audacity
    inkscape

    # Downloads
    qbittorrent
    localsend
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
