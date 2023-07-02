{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../dunst
    ../rofi
    # ../eww
    ../waybar
    ../gnome/gtk.nix
    ../gammastep
  ];

  home.packages = with pkgs; [
    brightnessctl
    qt6.qtwayland
    swaybg
    wl-clipboard
    cliphist
    polkit_gnome
    acpi
    inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
  ];

  home.file.".local/bin/cliphist-rofi".source = ./scripts/cliphist-rofi;

  programs = {
    zsh.loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
    zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
  };
    
  xdg.configFile."hypr/keymap.xkb".source = ../keymap.xkb;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = false;
    # disableAutoReload = false;
    recommendedEnvironment = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig =
      "exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1\n"
      + (builtins.readFile ./hyprland.conf);
  };
}
