# packages/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Base Packages ---
    home-manager
    ffmpeg
    limine
    neovim
    batsignal
    wget
    wl-clipboard-rs
    wl-clipboard
    git
    helix
    openssh
    mariadb
    emacs
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

    # --- NVIDIA drivers and related packages (Combined) ---
    nvidia-vaapi-driver
    nvidia-modprobe
  ];
}
