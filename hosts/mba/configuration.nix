{ modules, ... }: {
  imports = [ modules.common modules.nixosHost modules.hyprland ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
