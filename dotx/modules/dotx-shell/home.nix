{
  self,
  # dgs,
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
    # home.packages = [pkgs.dgs];
    #
    # programs.astal = {
    #   enable = true;
    #   extraPackages = [pkgs.libadwaita];
    # };
    #
    # programs.ags = {
    #   enable = true;
    #   configDir = dgs + "/src";
    #   extraPackages = [pkgs.accountsservice];
    # };
  };
}
