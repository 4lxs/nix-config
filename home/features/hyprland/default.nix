{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.hyprlock.homeManagerModules.default ];

  options.cfg.hyprland = {
    enable = lib.mkEnableOption "enable hyprland environment";
  };

  config = lib.mkIf config.cfg.hyprland.enable {
    cfg = {
      alacritty.enable = lib.mkDefault true;
      dunst.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
      gtk.enable = lib.mkDefault true;
      qt.enable = lib.mkDefault true;
      # eww.enable = lib.mkDefault true;
      # gammastep.enable = lib.mkDefault true;
    };

    home.packages = with pkgs; [
      brightnessctl
      qt6.qtwayland
      wl-clipboard
      cliphist
      libnotify
      libsForQt5.polkit-kde-agent

      # acpi
    ];

    programs.hyprlock = {
      enable = true;
      backgrounds = [ { path = "${./background.png}"; } ];
    };

    services = {
      # udiskie.enable = true;
      playerctld.enable = true;
      blueman-applet.enable = true;
      mpris-proxy.enable = true;
      syncthing = {
        enable = true;
        tray.enable = true;
      };
    };

    home.file.".local/bin/cliphist-rofi".source = ./scripts/cliphist-rofi;

    xdg.configFile."hypr/keymap.xkb".source = ../keymap/keymap.xkb;
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      extraConfig =
        with pkgs;
        builtins.readFile (substituteAll {
          src = ./hyprland.conf;
          inherit swaybg;
          polkit = libsForQt5.polkit-kde-agent;
        });
    };
  };
}
