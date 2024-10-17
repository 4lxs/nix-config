{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cfg.sddm = {
    enable = lib.mkEnableOption "enable sddm display manager";
  };

  config = lib.mkIf config.cfg.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
