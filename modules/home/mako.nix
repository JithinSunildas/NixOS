{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mako
  ];
  services.mako = {
    enable = true;
    settings = {
        borderSize = 2;
        defaultTimeout = 5000;
    };
  };
}
