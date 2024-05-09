{
  config,
  lib,
  ...
}: {
  options = {
    cfg.userDirs.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Use my custom directories for user directories.
        that is Downloads/Limbo for the download directory.
      '';
    };
  };

  config = lib.mkIf config.cfg.userDirs.enable {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        download = "${config.home.homeDirectory}/Downloads/Limbo";
      };
    };
  };
}
