_inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.gtk.enable {
    gtk = {
      enable = true;
      font = libx.cfg.theme.font.sansserif;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
        # package = pkgs.catppuccin-gtk;
        # name = "Catppuccin-Mocha-Compact-Muave-dark";
      };
      cursorTheme = {
        inherit (config.home.pointerCursor) name package;
        size = 24;
      };
      iconTheme = {
        name = "MoreWaita";
        package = pkgs.morewaita-icon-theme;
        # name = "Papirus-Dark";
        # package = pkgs.catppuccin-papirus-folders;
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
      color-scheme = "prefer-dark";
    };
  };
}
