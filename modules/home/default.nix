{ pkgs, config, ... }:

{
  home = {
    packages = [
    ];
  };

  imports = [
    # Packages
    ./packages/system.nix
    ./packages/terminal.nix
    ./packages/wayland.nix
    ./packages/themes.nix
    ./packages/security.nix
    ./packages/development.nix
    ./packages/languages.nix
    ./packages/virtualization.nix
    ./packages/apps.nix

    # Configs
    ./niri/niri.nix
    # ./mango/mango.nix
    ./waybar/waybar.nix
    ./theme/stylix.nix
    ./eww/eww.nix
    ./swaync/swaync.nix
    ./fish/fish.nix
    ./emacs/emacs.nix
    # ./neovim/neovim.nix
    ./nvf/default.nix
    ./xcompose/xcompose.nix
    ./ghostty.nix
    ./spicetify.nix
    ./bash.nix
    ./tmux.nix
    # ./mako.nix
    ./dunst.nix
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Libre Baskerville:size=12";
        terminal = "foot"; 
      };
      colors = {
        background = "0f0f0fcc";     
        text = "d1d1d1ff";           
        match = "ffffffff";          
        selection = "2a2a2acc";      
        selection-text = "ffffffff"; 
        border = "333333ff";         
      }; 
    };
  };
}
