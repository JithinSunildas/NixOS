{ pkgs, config, ... }:

{
  # 1. System-wide packages available in your user profile
  home.packages = with pkgs; [
    # Editors
    helix
    vscode

    # Build tools
    cmake
    cargo-zigbuild
    gnumake
    libvterm
    libtool
    pkg-config
    glibc
    glib

    # Design and Frontend
    typst
    tinymist
    pandoc

    # Hardware design
    iverilog

    # Mobile
    flutter
    android-tools

    # Backend / Java
    openjdk17
    maven
    gradle
    spring-boot-cli

    # PHP/Laravel
    (php83.withExtensions ({ all, ... }: with all; [
      pdo
      mbstring
      xml
      curl
      zip
      gd
    ]))

    # Databases
    mariadb
    postgresql
  ];

  home.sessionVariables = {
    NIX_CFLAGS_COMPILE = "-I${pkgs.glib.dev}/include/glib-2.0 -I${pkgs.glib.out}/lib/glib-2.0/include";
    NIX_LDFLAGS = "-L${pkgs.glib.out}/lib";
    PKG_CONFIG_PATH = "${pkgs.glib.out}/lib/pkgconfig";
  };

  nixpkgs.config = {
    android_sdk.accept_license = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    defaultEditor = true;
  };

  xdg.configFile."clangd/config.yaml".text = ''
    CompileFlags:
      If:
        PathMatch: .*\.c
      CompilationFlags:
        Add: [-std=c23, -Wall, -Wextra]

    ---
    If:
      PathMatch: .*\.(cpp|hpp|cc|cxx)
    CompileFlags:
      Add: [-std=c++23, -Wall, -Wextra]
  '';
}
