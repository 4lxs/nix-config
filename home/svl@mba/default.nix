{pkgs, ...}: {
  imports = [
    ../common.nix
    ../features/hyprland
  ];

  home = {
    username = "svl";
    homeDirectory = "/home/svl";
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
