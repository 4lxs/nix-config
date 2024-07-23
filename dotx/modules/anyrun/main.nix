{self, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.dotx-shell.enable {
    dotx.launcher = "anyrun";
  };
}
