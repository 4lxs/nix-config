{aylur, ...}: {
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.morewaita-icon-theme
    pkgs.gnome.adwaita-icon-theme
    pkgs.qogir-icon-theme
    pkgs.gnome.gnome-bluetooth
    pkgs.libdbusmenu-gtk3
  ];

  services = {
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
    upower.enable = true;
  };

  hardware.bluetooth.settings.General.Experimental = true; # for gnome-bluetooth percentage

  # services.greetd = {
  #   enable = true;
  #   settings.default_session.command = "${asztal}/bin/greeter";
  # };
}
