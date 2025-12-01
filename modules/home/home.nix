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
    ./bash.nix
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
    kmonad
    waypaper
    waybar
    swaylock
    swww
    dict
    spicetify-cli
    adw-gtk3
    papirus-icon-theme
    unzip
    xhost

    # Langs
    python3
    python3Packages.pip
    nixpkgs-fmt
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
    zed-editor
    chromium
    gnome-disk-utility
    discord
    ghostty
    kitty
    obs-studio
    spotify
    vscode
    kdePackages.okular
    gparted
    obsidian
    nautilus
    qbittorrent
    inputs.zen-browser.packages.${pkgs.system}.default

 # Virtualization/Container Tools
   docker
   docker-compose
   lazydocker

# === DEVELOPEMENT ===
    # === Flutter ===
    android-studio
    android-tools
    
    # === Java/Spring Boot ===
    jdk21
    maven
    gradle
    spring-boot-cli
    
    # === PHP/Laravel ===
    php83
    php83Extensions.pdo
    php83Extensions.mbstring
    php83Extensions.xml
    php83Extensions.curl
    php83Extensions.zip
    php83Extensions.gd
    
    # === Database ===
    mysql80
    postgresql
 ];

 home.pointerCursor = {
   enable = true;
   gtk.enable = true;
   package = pkgs.bibata-cursors;
   name = "Bibata-Modern-Classic";
   size = 24;
 };

  ########################################
  # 🧬 Git config
  ########################################
  programs = {

    git = {
      enable = true;
      settings.user.name = "JithinSunildas";
      settings.user.email = "jithinsunildas6@gmail.com";
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
  # services.postgresql = {
  #   enable = true;
  #   enableTCPIP = true;
  # };
}
