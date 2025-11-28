# modules/home/home.nix
{ config, pkgs, inputs, lib, ... }:

{
  home.username = "tikhaboom";
  home.homeDirectory = "/home/tikhaboom";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    ./waybar/waybar.nix
    ./niri/niri.nix
    ./fish.nix
    ./wofi.nix
    ./tmux.nix
    ./ghostty.nix
  ];

  ########################################
  # 🧰 User tools and base config
  ########################################
  home.packages = with pkgs; [
    fastfetch
    btop
    tmux
    starship
    swaynotificationcenter
    ghostty
    wofi
    alacritty
    fuzzel
    waybar-mpris
    playerctl
    waypaper
    waybar
    swaylock
    swww

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

    # User apps
    chromium
    discord
    obs-studio
    spotify
    vscode
    bitwarden
    obsidian
    qbittorrent
    inputs.zen-browser.packages.${pkgs.system}.default

 # Virtualization/Container Tools
   docker
   docker-compose
   lazydocker
 ];

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";

    colorScheme = "dark";
  };
  qt = {
    style.name = "adwaita-dark";
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaSapphire;
      name = "catppuccin-mocha-sapphire-cursors";
    size = 12;
  };

  ########################################
  # 🧬 Git config
  ########################################
  programs = {

    git = {
      enable = true;
      userName = "JithinSunildas";
      userEmail = "jithinsunildas6@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        color.ui = "auto";
      };
    };
  };

  ########################################
  # 🖥️ Shell config (optional)
  ########################################
  programs.bash.enable = true;
  programs.fish.enable = true;
  services.swww.enable = true;
  services.swaync.enable = true;
}
