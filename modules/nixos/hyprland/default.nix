{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
