{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # QEMU
    qemu_full
    virt-manager
    
    # Docker
    docker
    docker-compose
    lazydocker
  ];
}
