{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.cfg.eww = {
    enable = lib.mkEnableOption "enable eww widgets";
  };
  config = lib.mkIf config.cfg.eww.enable {
    programs.eww = {
      enable = true;
      package = pkgs.stable.eww-wayland;
      configDir = ./config;
    };
  };
}
