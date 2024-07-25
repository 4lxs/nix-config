{catppuccin, ...}: {pkgs, ...}: {
  imports = [catppuccin.nixosModules.catppuccin];

  catppuccin.enable = true;
  boot.plymouth.catppuccin.enable = false;
}
