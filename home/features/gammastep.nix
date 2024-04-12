{ lib, config, ... }:
{
  options.cfg.gammastep = {
    enable = lib.mkEnableOption "enable gammastep nightshift tool";
  };

  config = lib.mkIf config.cfg.gammastep.enable {
    services.gammastep = {
      enable = true;
      latitude = 46.05;
      longitude = 14.5;
      temperature = {
        day = 5500;
        night = 4000;
      };
    };
  };
}
