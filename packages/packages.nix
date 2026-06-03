# packages/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Base Packages ---
    home-manager
    ffmpeg
    limine
    neovim
    # batsignal
    throttled
    wget
    mangowc
    wl-clipboard-rs
    wl-clipboard
    git
    openssh
    curl
    wlogout
    eza
    libmtp
    zoxide
    bat
    tmux
    lazygit
    fzf
    nh
    gnumake
    brightnessctl
    cmatrix
    ly
    fish
    fastfetch
    btop
    ripgrep
    xwayland
    xwayland-satellite
  ];
}
