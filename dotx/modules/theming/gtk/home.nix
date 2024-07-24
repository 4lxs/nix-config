_inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
  ccfg = config.catppuccin.pointerCursor;
  cursorTheme = "catppuccin-${ccfg.flavor}-${ccfg.accent}-cursors";
in {
  config = mkIf libx.cfg.gtk.enable {
    gtk = {
      enable = true;
      font = libx.cfg.theme.font.sansserif;
      theme = {
        package = pkgs.adw-gtk3;
        name =
          if libx.cfg.theme.darkTheme
          then "adw-gtk3-dark"
          else "adw-gtk3";
      };
      cursorTheme = {
        name = cursorTheme;
        size = 24;
        package = pkgs.catppuccin-cursors;
      };
      iconTheme = {
        name = "MoreWaita";
        package = pkgs.morewaita-icon-theme;
      };
    };
    home = {
      pointerCursor = {
        # name = cursorTheme;
        size = 24;
        # package = pkgs.catppuccin-cursors;
        gtk.enable = true;
      };
    };
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme =
        if libx.cfg.theme.darkTheme
        then "prefer-dark"
        else "prefer-light";
    };
  };
}
