{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting "" 
      starship init fish | source
      source ~/nix-config/modules/home/fish/live.fish
    '';
  };
}
