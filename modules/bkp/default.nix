{ config, pkgs, ... }: {
  imports = [
    ./programs/ide.nix
    ./programs/dev-tools.nix
    ./programs/shell.nix
    ./programs/nvim.nix
  ];
}
