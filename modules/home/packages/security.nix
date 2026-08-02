{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Penetration testing
    bettercap
    nmap
    ffuf
    
    # VPN
    openvpn
    proton-vpn
  ];
}
