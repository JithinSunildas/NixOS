{ config, pkgs, ... }:

let
  emacsPackage = pkgs.emacs-pgtk;
  myDoomConfigDir = "~/nix-config/modules/home/emacs/doom";

in
{
  home.sessionVariables = {
    EMACSDIR = "${config.xdg.configHome}/emacs";
    DOOMDIR = myDoomConfigDir;
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
  };

  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];

  home.packages = with pkgs; [
    emacsPackage
    git
    fd       # Fast directory search (used by project search)
    ripgrep  # Fast file content search (used by project search)
    gnutls
    zstd
    # Language Servers (Recommended for your interests)
    haskell-language-server
  ];

  services.emacs = {
    enable = true;
    package = emacsPackage;
  };

  # 5. NEW: Declaratively provide your configuration files
  # This makes your init.el part of your Nix history.
  # home.file."${myDoomConfigDir}/init.el".source = ./path/to/your/init.el;
  # home.file."${myDoomConfigDir}/config.el".source = ./path/to/your/config.el;
}
