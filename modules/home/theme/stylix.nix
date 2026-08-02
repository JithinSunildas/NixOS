# modules/home/stylix.nix
{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    enableReleaseChecks = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    image = ./wallpapers/secluded-grove-pixel.png;
    polarity = "dark";

    # Configure fonts
    fonts = {
      serif = {
        package = pkgs.libre-baskerville;
        name = "Libre Baskerville";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 10;
        popups = 11;
      };
    };

    targets = {
      qt = {
        enable = true;
        platform = "qtct";
      };
      swaylock.enable = true;
      ghostty.enable = true;
      fish.enable = true;
      waybar.enable = true;
      fuzzel.enable = false;
      vim.enable = true;
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.vimix-cursors;
    name = "Vimix-cursors";
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Reversal-dark";
      package = pkgs.reversal-icon-theme;
    };
  };
}
