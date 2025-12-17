{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Penetration testing
    bettercap
    nmap
    hashcat
    metasploit
    ffuf
    
    # VPN
    openvpn
    protonvpn-gui
  ];
}
