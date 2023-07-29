{ inputs, outputs, lib, config, pkgs, ... }: {
    fonts.fontconfig.enable = true;
    xdg.dataFile."fonts".source = ./fonts;
    home.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        # font-awesome
    ];
}
