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
    ./theme/stylix.nix
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
    eww
    tmux
    starship
    swaynotificationcenter
    keyd
    wofi
    fuzzel
    waybar-mpris
    playerctl
    waypaper
    waybar
    swaylock
    swww
    dict
    spicetify-cli
    adw-gtk3
    papirus-icon-theme

    # Langs
    python3
    python3Packages.pip
    go
    rustup
    clang
    iverilog

    # Security/Penetration Testing Tools
    nmap
    openvpn
    hashcat
    metasploit
    ffuf

    # User apps
    chromium
    discord
    ghostty
    kitty
    obs-studio
    spotify
    vscode
    kdePackages.okular
    obsidian
    nautilus
    qbittorrent
    inputs.zen-browser.packages.${pkgs.system}.default

 # Virtualization/Container Tools
   docker
   docker-compose
   lazydocker
 ];

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
  services.ssh-agent.enable = true;
  services.swww.enable = true;
  services.swaync.enable = true;
}
