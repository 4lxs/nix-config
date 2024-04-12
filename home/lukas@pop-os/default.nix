{ modules, ... }:
{
  imports = [
    modules.common
    modules.nixpkgs
    modules.tmux
    modules.zsh
    modules.fonts
    modules.git
    modules.alacritty
    modules.nixpkgs
    modules.qt
    modules.shutils
    modules.zathura
  ];

  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";
  };
}
