_inputs: {
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.kdeconnect.enable {
    programs.gnome-shell = {
      enable = true;
      extensions = [{package = pkgs.gnomeExtensions.gsconnect;}];
    };
  };
}
