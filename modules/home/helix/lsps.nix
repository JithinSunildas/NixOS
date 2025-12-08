pkgs: config:
with pkgs; let

  isArm = pkgs.system == "aarch64-linux";

  extensionsIf = cond: extensions:
    if cond
    then extensions
    else [];

  x64PkgsOnly = extensionsIf (!isArm) [
    terraform-ls
    starpls-bin
  ];
in
  [
    #cpp
    llvmPackages_20.clang-tools
    lldb_20

    # nix
    alejandra
    nil

    # scala
    metals
    coursier

    # go
    gopls
    go

    # python
    basedpyright
    ruff

    # qml... pretty big. we should remove it
    kdePackages.qtdeclarative

    # js
    biome
    typescript-language-server
    vscode-langservers-extracted
    stylelint-lsp

    # rust
    rust-toolchain

    # protobuf
    buf

    # other
    config.programs.git.package
    config.programs.yazi.package
  ]
  ++ x64PkgsOnly
