_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.kde.enable {
    # TODO: kvantum adw-gtk3
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
      # platformTheme.name = "adwaita";
      # style.name =
      #   if libx.cfg.theme.darkTheme
      #   then "adwaita-dark"
      #   else "adwaita";
    };
  };
}
