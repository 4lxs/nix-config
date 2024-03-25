{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../common.nix
    ../features/hyprland
    # ../features/python
    # ../features/hacking
  ];

  home = {
    username = "svl";
    homeDirectory = "/home/svl";
    packages = with pkgs; [
      socat
      jq
      shfmt
      mpv
      calibre
      # stig
      # qbittorrent
      # androidStudioPackages.canary
      gcc
    ];
  };

  programs = {
    # vscode.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  services = {
    # udiskie.enable = true;
    playerctld.enable = true;
    blueman-applet.enable = true;
    mpris-proxy.enable = true;
    # kdeconnect = {
    #   enable = true;
    #   indicator = true;
    # };
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
