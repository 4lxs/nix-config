{anyrun, ...}: {
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.anyrun.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = [
          anyrun.packages.${pkgs.system}.applications
          anyrun.packages.${pkgs.system}.rink
          anyrun.packages.${pkgs.system}.translate
          anyrun.packages.${pkgs.system}.dictionary
          anyrun.packages.${pkgs.system}.websearch
          # ./some_plugin.so
          # "${anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/kidex"
        ];
        x = {fraction = 0.5;};
        y = {fraction = 0.3;};
        width = {fraction = 0.3;};
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = true;
        showResultsImmediately = false;
        maxEntries = null;
      };
      extraCss = builtins.readFile ./style.css;

      # extraConfigFiles."some-plugin.ron".text = ''
      #   Config(
      #     // for any other plugin
      #     // this file will be put in ~/.config/anyrun/some-plugin.ron
      #     // refer to docs of xdg.configFile for available options
      #   )
      # '';
    };
  };
}
