{ pkgs, config, ... }:

{
  # 1. System-wide packages available in your user profile
  home.packages = with pkgs; [
    # Editors
    helix
    vscode
    antigravity-ide

    # Build tools
    cmake
    cargo-zigbuild
    gnumake
    pkg-config
    glibc
    libsecret

    # Design and Frontend
    typst
    tinymist
    pandoc

    # Mobile
    android-tools

    # PHP/Laravel
    (php83.withExtensions (
      { all, ... }: with all;
      [
        pdo
        mbstring
        xml
        curl
        zip
        gd
      ]
    ))

    # Databases
    postgresql
  ];

  nixpkgs.config = {
    android_sdk.accept_license = true;
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
