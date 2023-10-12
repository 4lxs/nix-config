{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    gitmux
    fzf
    (writeScriptBin "svl-sessionizer.sh" (lib.readFile ./sessionizer.sh))
  ];
  xdg.configFile."tmux/gitmux.conf".source = ./gitmux.conf;
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];

    extraConfig = (lib.readFile ./tmux.conf);
  };
}
