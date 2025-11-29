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
    eza
    zoxide
    bat
    tmux
    lazygit
    fzf
    nh
    gnumake
    brightnessctl
    ly
    fish
    fastfetch
    btop
    ripgrep
    nixfmt-rfc-style
    xwayland
    xwayland-satellite

    # --- NVIDIA drivers and related packages (Combined) ---
    nvidia-vaapi-driver
    nvidia-modprobe
  ];
}
