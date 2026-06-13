{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mako
  ];
  services.mako = {
    enable = true;
    font = "Libre Baskerville";
    borderSize = 2;
    defaultTimeout = 5000;
  };
}
