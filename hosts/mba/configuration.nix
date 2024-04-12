{
  cfg = {
    nixosHost.enable = true;
    hyprland.enable = true;
    appleSilicon.enable = true;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 6 * 1024;
    }
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
