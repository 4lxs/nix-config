{pkgs, ...}: {
  home.packages = with pkgs; [
        ripgrep
        fd
        socat
        unzip
        wget
        jq
        htop
        p7zip
  ];
}
