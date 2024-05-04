{ lib, config, ... }:
{
  options.cfg.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.cfg.hyprland.enable {
    services.upower.enable = true;
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
