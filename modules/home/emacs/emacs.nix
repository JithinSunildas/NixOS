{ config, pkgs, ... }:

let
  emacsPackage = pkgs.emacs-pgtk;

in
{
  home.sessionVariables = {
    EMACSDIR = "/home/tikhaboom/nix-config/modules/home/emacs"; 
    DOOMDIR = "/home/tikhaboom/nix-config/modules/home/emacs/doom";   
    DOOMLOCALDIR = "/home/tikhaboom/nix-config/modules/home/emacs/doom";
  };

  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];

  home.packages = with pkgs; [
    emacsPackage
    git
    fd     
    gnutls 
    zstd   
    
    haskell-language-server
  ];

  services.emacs = {
    enable = true;
    package = emacsPackage; 
    # Optional: ensure it restarts if it crashes
    # serviceConfig.Restart = "on-failure"; 
  };
}
