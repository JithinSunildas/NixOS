# packages/packages.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Base Packages ---
    ffmpeg
    neovim
    wget
    wl-clipboard-rs
    git
    curl
    wlogout
    lsd
    bat
    tmux
    lazygit
    fzf
    adw-gtk3
    papirus-icon-theme
    nh
    xfce.thunar
    gnumake
    go
    ly
    fish
    fastfetch
    btop
    nixfmt-rfc-style
    xwayland
    xwayland-satellite

    # --- NVIDIA drivers and related packages (Combined) ---
    nvidia-vaapi-driver
    nvidia-modprobe
  ];
}
