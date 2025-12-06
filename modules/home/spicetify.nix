{ pkgs, lib, spicetify-nix, ... }:
{
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblock
      hidePodcasts
    ];
    enabledCustomApps = with spicetify-nix.legacyPackages.${pkgs.system}.apps; [
      marketplace
    ];
  };
}
