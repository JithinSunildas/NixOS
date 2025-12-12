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
    fd               
    ripgrep          
    fzf              
    zoxide           
    man-db
    man-pages
  ];
}
