{self, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.dotx-shell.enable {
    # dotx.launcher = "${pkgs.asztal}/bin/asztal --toggle-window launcher";
  };
}
