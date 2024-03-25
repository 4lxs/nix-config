{ inputs, outputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    sddm-themes.sugar-dark
  ];

  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-sugar-dark";
  };
}
