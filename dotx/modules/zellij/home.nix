_inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.zellij.enable {
    # xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    xdg.configFile."zellij/plugins/zellij-sessionizer.wasm".source = pkgs.fetchurl {
      url = "https://github.com/laperlej/zellij-sessionizer/releases/download/v0.4.3/zellij-sessionizer.wasm";
      hash = "sha256-AGuWbuRX7Yi9tPdZTzDKULXh3XLUs4navuieCimUgzQ=";
    };
    home.packages = [pkgs.zellij];
    # programs.zellij = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   enableFishIntegration = true;
    # };
  };
}
