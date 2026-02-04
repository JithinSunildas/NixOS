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
    wget
    wl-clipboard-rs
    wl-clipboard
    git
    helix
    openssh
    mariadb
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
    nixfmt-rfc-style
    xwayland
    xwayland-satellite
  ];
}
