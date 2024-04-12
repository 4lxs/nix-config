{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.cfg.fonts = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable fontconfig support";
    };
  };
  config = lib.mkIf config.cfg.fonts.enable {
    fonts.fontconfig.enable = true;
    xdg.dataFile."fonts".source = ./fonts;
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      # font-awesome
    ];
  };
}
