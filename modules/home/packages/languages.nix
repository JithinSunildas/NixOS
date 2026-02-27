{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Nix
    nixd
    nil
    nixpkgs-fmt

    # Python
    python312
    python3Packages.pip
    pyright
    black

    # Go
    go

    # Rust
    rustup
    pkg-config

    # C/C++/Zig
    (pkgs.lib.hiPrio pkgs.clang)
    (pkgs.lib.hiPrio pkgs.vim)
    clang-tools
    lld
    lldb
    gcc
    zig_0_15

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
