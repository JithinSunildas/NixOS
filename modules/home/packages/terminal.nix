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
    asciinema
    fd               
    ripgrep          
    fzf              
    lf
    zoxide           
    man-db
    man-pages
    man-pages-posix
  ];
}
