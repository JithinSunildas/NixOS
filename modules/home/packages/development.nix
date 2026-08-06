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
    pandoc

    # Mobile
    android-tools

    # Databases
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
