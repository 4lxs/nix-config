{ inputs, outputs, lib, config, pkgs, ... }: {
    programs.eww = {
        enable = true;
        package = pkgs.stable.eww-wayland;
        configDir = ./config;
    };
}