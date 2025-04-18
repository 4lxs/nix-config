_inputs: {
  config,
  lib,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.userDirs.enable {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        download = "${config.home.homeDirectory}/Downloads/Limbo";
      };
    };
  };
}
