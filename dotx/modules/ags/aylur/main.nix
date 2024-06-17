{self, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.ags.aylur.enable {
    dotx.launcher = "${pkgs.asztal}/bin/asztal --toggle-window launcher";
  };
}
