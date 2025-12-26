{ pkgs, config, ... }:

{
  home = {
    username = "tikhaboom";
    homeDirectory = "/home/tikhaboom";
    stateVersion = "25.05";
    
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
    ./waybar/waybar.nix
    ./theme/stylix.nix
    ./fish/fish.nix
    ./neovim/neovim.nix
    ./zellij/zellij.nix
    ./ghostty.nix
    ./spicetify.nix
    ./bash.nix
    ./tmux.nix
    ./dunst.nix
  ];
}
