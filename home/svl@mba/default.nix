{pkgs, ...}: {
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
      mpv
      calibre
      # stig
      # qbittorrent
      # androidStudioPackages.canary
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
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
