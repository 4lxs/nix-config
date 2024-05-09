{modules, ...}: {
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
  ];

  # TODO: find out a way to alias applications for spotlight

  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";
  };
}
