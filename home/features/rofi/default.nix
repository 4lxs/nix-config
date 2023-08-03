{ inputs, outputs, lib, config, pkgs, ... }: {
    xdg.configFile."rofi/themes" = {
        source = ./themes;
        recursive = true;
    };
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = ./themes/spotlight-dark.rasi;
        extraConfig = {
            show-icons = true;
            icon-theme = "Papirus";
            display-drun = "";
            display-window = "﩯 ";
            display-combi = "  ";
        };
    };
}