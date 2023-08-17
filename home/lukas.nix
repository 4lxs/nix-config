{ inputs, outputs, lib, config, pkgs, ... }: {
    imports = [
        ./features/alacritty
        ./common.nix
    ];

    home = {
        username = "lukas";
        homeDirectory = "/home/lukas";
        sessionPath = [
          "$HOME/go/bin"
        ];
    };

    programs = {
      go.enable = true;
    };
}
