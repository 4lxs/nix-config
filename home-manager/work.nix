{ inputs, outputs, lib, config, pkgs, ... }: {
    imports = [
        ./common.nix
    ];

    home = {
        username = "lukas";
        homeDirectory = "/home/lukas";
    };
}