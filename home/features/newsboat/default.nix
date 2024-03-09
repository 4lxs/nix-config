{ pkgs, lib, ... }:
{
  programs.newsboat = {
    enable = true;
    extraConfig = ''
      urls-source "ocnews"
      ocnews-url "https://svl.aero.usbx.me/nextcloud/"
      ocnews-login "svl"
      ocnews-passwordfile "~/.config/nextcloud/password"
    '';
  };
}
