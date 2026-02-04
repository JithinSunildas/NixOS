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
    ./waybar/waybar.nix
    ./theme/stylix.nix
    ./swaync/swaync.nix
    ./fish/fish.nix
    ./neovim/neovim.nix
    ./zellij/zellij.nix
    ./xcompose/xcompose.nix
    ./ghostty.nix
    ./spicetify.nix
    ./bash.nix
    ./tmux.nix
    ./dunst.nix
  ];
}
