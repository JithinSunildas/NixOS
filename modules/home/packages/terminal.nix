{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    # Terminal multiplexers
    tmux

    # Terminals
    ghostty
    kitty

    # Shell tools
    nushell
    starship
    dict
    asciinema
    fd
    ripgrep
    fzf
    lf
    zoxide
    eza
    btop
    man-db
    man-pages
    man-pages-posix
    neomutt
  ];
  home.file.".dict/dict.conf".text = ''
    server localhost
  '';
}
