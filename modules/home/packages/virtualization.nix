{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # QEMU
    qemu
    
    # Docker
    docker
    docker-compose
    lazydocker
  ];
}
