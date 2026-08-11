{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # QEMU
    qemu_kvm
    virt-manager
  ];
}
