{ lib, config, ... }:
{
  options.cfg.kdeconnect = {
    enable = lib.mkEnableOption "enable kdeconnect";
  };
  config = lib.mkIf config.cfg.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
