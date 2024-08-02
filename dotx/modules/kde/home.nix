_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.kde.enable {
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
      style.catppuccin.enable = true;
    };
  };
}
