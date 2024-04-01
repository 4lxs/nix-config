{ inputs, outputs, lib, config, pkgs, ... }: {
  services.gammastep = {
    enable = true;
    latitude = 46.05;
    longitude = 14.5;
    temperature = {
      day = 5500;
      night = 4000;
    };
  };
}
