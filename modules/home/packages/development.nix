{ pkgs, config, ... }:
{
  pkgs.mkShell = {
    buildInputs = with pkgs; [
  
# Editors
      helix
      vscode

# Build tools
      cmake
      cargo-zigbuild
      gnumake
      libvterm
      glibtool
      pkg-config
      glib.dev

# Design and Frontend
      typst
      tinymist
      pandoc

# Hardware design
      iverilog

# Mobile
      flutter
      android-tools

# Backend
# Java/Spring Boot
      jdk21
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
NIX_CFLAGS_COMPILE = [ "-I${glib.dev}/include" ];
  NIX_LDFLAGS = [ "-L${glib.lib}" ];

  # Set the PKG_CONFIG_PATH to include pkg-config files for glib during build
  PKG_CONFIG_PATH = "${glib.lib}/pkgconfig";
  nixpkgs.config = {
    android_sdk.accept_license = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
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
    CompileFlags:
      Add: [-std=c23, -Wall, -Wextra]

    ---
    If:
      PathMatch: .*\.(cpp|hpp|cc|cxx)
    CompileFlags:
      Add: [-std=c++23, -Wall, -Wextra]
  '';
};
