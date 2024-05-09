{
  pkgs,
  ...
}:
{
  cfg = {
    rofi.enable = true;
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
