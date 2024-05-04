{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.dotx.homeManagerModules.dotx ];

  cfg = {
    # hyprland.enable = true;
    rofi.enable = true;
    kdeconnect.enable = true;
  };

  dotx = {
    config = "svl";
  };

  home = {
    packages = with pkgs; [
      vscode-fhs
      obsidian
      calibre
      gnome.nautilus
      # taskwarrior
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
  };
}
