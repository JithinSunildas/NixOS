{ pkgs, lib, spicetify-nix, ... }:
{
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
      adblock
      hidePodcasts
    ];
    enabledCustomApps = with spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps; [
      marketplace
    ];
  };
}
