{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.cfg.sddm = {
    enable = lib.mkEnableOption "enable sddm display manager";
  };

  config = lib.mkIf config.cfg.sddm.enable {
    environment.systemPackages = with pkgs; [ sddm-themes.sugar-dark ];

    services.xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-sugar-dark";
    };
  };
}
