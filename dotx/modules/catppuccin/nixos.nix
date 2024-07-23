{catppuccin, ...}: {pkgs, ...}: {
  imports = [catppuccin.nixosModules.catppuccin];

  catppuccin.enable = true;
}
