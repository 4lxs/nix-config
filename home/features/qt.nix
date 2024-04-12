{ config, lib, ... }:
{
  options.cfg.qt = {
    enable = lib.mkEnableOption "enable qt theming";
  };
  config = lib.mkIf config.cfg.qt.enable {
    qt = {
      enable = true;
      platformTheme = "gtk";
      style.name = "adwaita-dark";
    };
  };
}
