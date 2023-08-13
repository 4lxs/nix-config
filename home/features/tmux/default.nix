{ inputs, lib, config, pkgs, ... }: { # tmux config
  home.packages = with pkgs; [
    gitmux
  ];
  programs.tmux = {
    enable = true;
    mouse = false;
    baseIndex = 1;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-dir '~/.config/tmux/resurrect'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];

    extraConfig = (lib.readFile ./tmux.conf);
  };
}
