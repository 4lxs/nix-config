{catppuccin, ...}: {pkgs, ...}: {
  imports = [catppuccin.homeModules.catppuccin];

  catppuccin = {
    enable = true;
    cursors.enable = true;
    tmux.enable = false;
    # hyprland.enable = true;
    gtk.enable = false;
    gtk.gnomeShellTheme = false;
  };
}
