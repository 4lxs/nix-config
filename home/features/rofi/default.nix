{ pkgs, ... }: {
  # TODO: this is ugly
  xdg.configFile."rofi/powermenu" = {
    source = ./powermenu;
    recursive = true;
  };
  home.packages = with pkgs; [
    rofi-wayland
    # (pkgs.writeShellScriptBin "launcher.sh" ''
    #   rofi -show drun -theme "${./launcher/theme.rasi}"
    # '')
  ];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./launcher/theme.rasi;
    font = "FiraCode Nerd Font Medium 12";
    extraConfig = {
      modi = "drun,window,combi";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "󱃸 ";
      display-window = "󰣆 ";
      display-combi = "󰕘 ";
    };
  };
}
