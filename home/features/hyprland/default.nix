{ inputs, pkgs, ... }: {
  imports = [
    inputs.hyprlock.homeManagerModules.default

    ../dunst
    ../rofi
    # ../eww
    ../waybar
    ../gnome/gtk.nix
    # ../gammastep
  ];

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
    backgrounds = [
      {
        path = "${./background.png}";
      }
    ];
  };

  home.file.".local/bin/cliphist-rofi".source = ./scripts/cliphist-rofi;

  xdg.configFile."hypr/keymap.xkb".source = ../keymap/keymap.xkb;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = with pkgs; builtins.readFile (substituteAll {
      src = ./hyprland.conf;
      inherit swaybg;
      polkit = libsForQt5.polkit-kde-agent;
    });
  };
}
