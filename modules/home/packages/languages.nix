{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ollama

    # Nix
    nixd
    nil
    nixpkgs-fmt

    # Python
    (python313.withPackages (ps: with ps; [ 
      black 
      pyright
    ]))

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
    zig

    # JavaScript/TypeScript
    nodejs

    # Other
    superhtml
  ];
}
