{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libvterm
    libtool
    glib
    (texlive.combine {
        inherit (texlive) 
        scheme-medium
        wrapfig
        capt-of;
    })
  ];

  home.sessionVariables = {
    NIX_CFLAGS_COMPILE = "-I${pkgs.glib.dev}/include/glib-2.0 -I${pkgs.glib.out}/lib/glib-2.0/include";
    NIX_LDFLAGS = "-L${pkgs.glib.out}/lib";
    PKG_CONFIG_PATH = "${pkgs.glib.out}/lib/pkgconfig";
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    defaultEditor = true;
  };

  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink "/home/tikhaboom/nix-config/modules/home/emacs/config";
}
