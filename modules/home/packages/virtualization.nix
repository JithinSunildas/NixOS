{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # QEMU
    qemu_full
    
    # Docker
    docker
    docker-compose
    lazydocker
  ];
}
