{catppuccin, ...}: {pkgs, ...}: {
  imports = [catppuccin.homeManagerModules.catppuccin];

  catppuccin = {
    enable = true;
    pointerCursor.enable = true;
  };
  gtk.catppuccin.enable = false;
  gtk.catppuccin.gnomeShellTheme = false;
  programs.tmux.catppuccin.enable = false;
  wayland.windowManager.hyprland.catppuccin.enable = true;
}
