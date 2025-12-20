# modules/home/stylix.nix
{
    pkgs,
        ...
}:
{
    stylix = {
        enable = true;
        # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
        base16Scheme = ./kanso.yaml;
        image = ./wallpapers/demo.jpg;
        polarity = "dark";

        cursor = {
            package = pkgs.vimix-cursors;
            name = "Vimix-cursors";
            size = 24;
        };

# Configure fonts
        fonts = {
            serif = {
                package = pkgs.libre-baskerville;
                name = "Libre Baskerville";
            };
            sansSerif = {
                package = pkgs.inter;
                name = "Inter";
# package = pkgs.merriweather-sans;
# name = "Merriweather Sans";
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

            fuzzel.enable = true;
            neovim = {
                enable = true;
                transparentBackground.main = false;
                transparentBackground.signColumn = false;
            };
            helix.enable = true;
        };
    };

    gtk = {
        enable = true;
        iconTheme = {
            name = "Reversal-dark";
            package = pkgs.reversal-icon-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "qtct";
    };
}
