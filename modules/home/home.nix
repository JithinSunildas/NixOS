# modules/home/home.nix
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "tikhaboom";
  home.homeDirectory = "/home/tikhaboom";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    inputs.nvf.homeManagerModules.default
    ./niri/niri.nix
    ./waybar/waybar.nix
    ./theme/stylix.nix
    ./fish/fish.nix
    ./ghostty.nix
    ./spicetify.nix
    ./bash.nix
    ./tmux.nix
    ./dunst.nix
  ];

  ########################################
  # 🧰 User tools and base config
  ########################################
  home.packages = with pkgs; [
    eww
    tmux
    starship
    swaynotificationcenter
    keyd
    wofi
    yazi
    fuzzel
    waybar-mpris
    playerctl
    kmonad
    waypaper
    helix
    waybar
    swaylock
    gifski
    swayosd
    swww
    dict
    adw-gtk3
    papirus-icon-theme
    unzip
    dunst
    xhost
    ninja
    pkg-config

    # Security/Penetration Testing Tools
    bettercap
    nmap
    openvpn
    hashcat
    metasploit
    ffuf

    # User apps
    libreoffice
    zed-editor
    chromium
    firefox
    gnome-disk-utility
    gnome-calculator
    telegram-desktop
    mpv
    discord
    ghostty
    kitty
    obs-studio
    vscode
    kdePackages.okular
    gparted
    protonvpn-gui
    dbeaver-bin
    obsidian
    nautilus
    qbittorrent
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Langs
    python3
    python3Packages.pip
    nixpkgs-fmt
    go
    rustup
    nodePackages_latest.coc-clangd
    clang
    cmake
    iverilog
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.stack
    nodejs
    clang-tools
    lldb
    jdt-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    pyright
    nodePackages.prettier
    black

    # Virtualization/Container Tools
    docker
    docker-compose
    lazydocker

    # === Flutter ===
    flutter
    androidsdk
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

  nixpkgs.config = {
    android_sdk.accept_license = true;
  };

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
      settings = {
        user.name = "JithinSunildas";
        user.email = "jithinsunildas6@gmail.com";
        init.defaultBranch = "main";
        pull.rebase = true;
        color.ui = "auto";
      };
    };
  };

    # You can add other top-level NVF options here if you want to configure
    # things outside of the 'vim' attribute set.
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
