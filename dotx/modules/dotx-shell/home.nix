{
  self,
  aylur,
  matugen,
  dgs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.dotx-shell.enable {
    home.packages = [dgs.packages.${pkgs.system}.dgs];

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
