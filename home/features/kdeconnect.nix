{ lib, ... }:
{
  options.cfg.kdeconnect = {
    enable = lib.mkEnableOption "enable kdeconnect";
  };
  kdeconnect = {
    enable = true;
    indicator = true;
  };
}
