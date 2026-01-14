{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Nix
    nixd
    nil
    nixpkgs-fmt

    # Python
    python3
    python3Packages.pip
    pyright
    black

    # Go
    go

    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy
    lld
    pkg-config

    # C/C++
    (pkgs.lib.hiPrio pkgs.clang)
    clang-tools
    lldb
    gcc

    # Haskell
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.stack

    # JavaScript/TypeScript
    nodejs
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier

    # Java
    jdt-language-server

    # Other
    superhtml
  ];
}
