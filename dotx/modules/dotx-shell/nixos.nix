{wallpkgs, ...}: {
  config,
  pkgs,
  lib,
  host_config,
  ...
}: let
  walls = wallpkgs.packages.${pkgs.system}.catppuccin;
  path = "${walls}/share/wallpapers/catppuccin/05.png";

  homeCfg = config.home-manager.users.${host_config.user};

  libx = config.lib.dotx;
  hypr-pkg = config.programs.hyprland.package;
  hypr-run = pkgs.writeShellScriptBin "hypr-run" ''
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="Hyprland"
    export XDG_CURRENT_DESKTOP="Hyprland"

    systemd-run --user --scope --collect --quiet --unit="hyprland" \
        systemd-cat --identifier="hyprland" ${hypr-pkg}/bin/Hyprland $@

    ${hypr-pkg}/bin/hyprctl dispatch exit
  '';
in {
  environment.systemPackages = [
    pkgs.morewaita-icon-theme
    pkgs.gnome.adwaita-icon-theme
    pkgs.qogir-icon-theme
    pkgs.gnome.gnome-bluetooth
    pkgs.libdbusmenu-gtk3
    pkgs.catppuccin-gtk
    pkgs.catppuccin-papirus-folders
    pkgs.catppuccin-cursors
    homeCfg.home.pointerCursor.package
  ];

  services = {
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
    upower.enable = true;
  };

  hardware.bluetooth.settings.General.Experimental = true; # for gnome-bluetooth percentage

  # programs.regreet = {
  #   enable = true;
  #   settings = {
  #     background = {
  #       inherit path;
  #       fit = "Cover";
  #     };
  #     GTK = {
  #       # cursor_theme_name = "Catppuccin-Mocha-Dark-Cursors";
  #       font_name = "Roboto 12";
  #       # icon_theme_name = "Papirus-Dark";
  #       # theme_name = "Catppuccin-Mocha-Compact-Peach-dark";
  #       cursor_theme_name = homeCfg.home.pointerCursor.name;
  #       # font_name = libx.cfg.theme.font.sansserif;
  #       icon_theme_name = homeCfg.gtk.iconTheme.name;
  #       theme_name = homeCfg.gtk.theme.name;
  #     };
  #   };
  # };

  # services.greetd.settings.default_session.command = "${hypr-run}/bin/hypr-run";
}
