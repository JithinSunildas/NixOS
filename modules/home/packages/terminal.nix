{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal multiplexers
    tmux
    zellij
    
    # Terminals
    ghostty
    kitty
    
    # Shell tools
    starship
    dict
  ];
}
