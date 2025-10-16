{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.gcc
    pkgs.gdb
    pkgs.valgrind
    pkgs.android-tools
  ];
}
