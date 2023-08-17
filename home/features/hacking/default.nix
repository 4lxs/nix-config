{ pkgs, ... }: {
  home.packages = with pkgs; [
    openvpn
    nmap
    gobuster
    zap
    metasploit
  ];
}
