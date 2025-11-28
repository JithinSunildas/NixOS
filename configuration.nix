{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  networking = {
    hostName = "SuperDuperComputer";
    networkmanager.enable = true;
    hosts = {
      "192.168.18.33" = [ "raspi.casa.local" ];
      "10.129.16.223" = [
        "blog.inlanefreight.local"
        "blog-dev.inlanefreight.local"
      ];
    };
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.tikhaboom = {
    isNormalUser = true;
    description = "tikhaboom";
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "docker"
    ];
    packages = with pkgs; [
      chromium
    ];
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
    nvidia-vaapi-driver
    nvidia-modprobe
    neovim
    wget
    wl-clipboard-rs
    git
    curl
    wlogout
    discord
    obs-studio
    spotify
    lsd
    bat
    tmux
    lazygit
    fzf
    lazydocker
    wofi
    ghostty
    vscode
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
    bitwarden
    docker
    docker-compose
    xdg-desktop-portal-wlr
    polkit
    nixfmt-rfc-style
    obsidian
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
    qbittorrent

    xwayland
    xwayland-satellite
  ];

  programs = {

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    wireshark.enable = true;

    niri.enable = true;
    xwayland.enable = true;
    obs-studio.enable = true;
    obs-studio.plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };
  xdg.portal.wlr.enable = true;
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
  services = {
    qbittorrent.enable = true;
    displayManager.enable = true;
    displayManager.ly.enable = true;
    # services.openssh.enable = true;
  };

  security.polkit.enable = true;
  virtualisation.docker.enable = true;

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
