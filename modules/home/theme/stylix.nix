# modules/home/stylix.nix
{ config, pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    
    image = ./wallpapers/wade-meng-LgCj9qcrfhI-unsplash.jpg;
    
    polarity = "dark";
    
    targets.qt = {
      enable = true;
      platform = "qtct";
    };
  };
  
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
}
