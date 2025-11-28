{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    wofi
    ghostty
    adw-gtk3
    papirus-icon-theme
    nh
    xfce.thunar
    gnumake
    go
    ly
    fish
    alacritty
    fuzzel
    fastfetch
    btop
    nixfmt-rfc-style
    xwayland
    xwayland-satellite
  ];

  environment.systemPackages = (config.environment.systemPackages or []) ++ (with pkgs; [
    # Security/Penetration Testing Tools
    nmap
    openvpn
    hashcat
    burpsuite
    caido
    wireshark
    rockyou
    seclists
    metasploit
    gobuster
    ffuf
    sqlmap
    john
    thc-hydra
  ]);

  # Separate block for proprietary/user apps
  environment.systemPackages = (config.environment.systemPackages or []) ++ (with pkgs; [
    chromium
    discord
    obs-studio
    spotify
    vscode
    bitwarden
    obsidian
    qbittorrent
  ]);

  # Virtualization/Container Tools
  environment.systemPackages = (config.environment.systemPackages or []) ++ (with pkgs; [
    docker
    docker-compose
    lazydocker
  ]);

  # NVIDIA drivers and related packages
  environment.systemPackages = (config.environment.systemPackages or []) ++ (with pkgs; [
    nvidia-vaapi-driver
    nvidia-modprobe
  ]);
}
