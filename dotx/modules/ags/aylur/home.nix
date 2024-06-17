{
  self,
  aylur,
  matugen,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.ags.aylur.enable {
    home.packages = [pkgs.asztal];
    programs.astal = {
      enable = true;
      extraPackages = [pkgs.libadwaita];
    };

    programs.ags = {
      enable = true;
      configDir = aylur + "/ags";
      extraPackages = [pkgs.accountsservice];
    };
  };
}
