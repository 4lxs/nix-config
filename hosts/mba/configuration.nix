{ modules, ... }:
{
  imports = [
    modules.common
    modules.nixosHost
    modules.hyprland
    modules.appleSilicon
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 6 * 1024;
    }
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
