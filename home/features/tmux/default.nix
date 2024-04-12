{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.cfg.tmux = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable tmux multiplexer";
    };
  };

  config = lib.mkIf config.cfg.tmux.enable {
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

      extraConfig =
        ''
          set-option -g default-shell ${pkgs.zsh}/bin/zsh
        ''
        + (lib.readFile ./tmux.conf);
    };
  };
}
