{ pkgs, modules, config, ... }: {
  imports = [
    modules.common
    modules.tmux
    modules.zsh
    modules.fonts
    modules.git
    modules.alacritty
    modules.qt
    modules.hyprland
    modules.firefox
    modules.shutils
    modules.zathura
  ];

  cfg = { nixColors.enable = true; };
  xdg.userDirs.download = "${config.home.homeDirectory}/Downloads/Limbo";

  home = {
    packages = with pkgs; [ vscode-fhs obsidian calibre ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
  };
}
