{ inputs, lib, config, pkgs, ... }: { # tmux config
  programs.tmux = {
    enable = true;
    # mouse = true;
    baseIndex = 1;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
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

    extraConfig = '' # copied directly to tmux.conf
      set-option -g default-shell ~/.nix-profile/bin/zsh
      # look-and-feel
      set-option -g message-style fg=colour7 # message infos
      set-option -g pane-active-border-style fg=colour7 # split pane border
      set-option -g pane-border-style fg=colour15
      set-option -g status "on" # statusline
      set -g focus-events on
      set -g status-left-length 80
      set -g status-right-length 80
      set -g status-justify absolute-centre
      set-option -g status-style bg=default,fg=default
      set -g status-left '#{?#(cat #{socket_path}-\#{session_id}-vimbridge),#(cat #{socket_path}-\#{session_id}-vimbridge),#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#15161e,nobold]}'
      set -g status-right '#(cat #{socket_path}-\#{session_id}-vimbridge-R)'
      set-window-option -g window-status-separator ""
      set -g window-status-current-format " #[fg=#7aa2f7]\uE0B6#[fg=#15161e,bg=#7aa2f7,bold]#{?window_zoomed_flag,🔍,}#W#[fg=#7aa2f7,bg=#15161e,nobold]\uE0B4"
      set -g window-status-format " #[fg=colour15]\uE0B6#[fg=default,bg=colour15]#W#[fg=colour15,bg=default]\uE0B4"
      
      bind-key -n C-a send-prefix # have C-a be prefix in nested session

      # system clipboard
      bind -T copy-mode    C-c send -X copy-pipe-no-clear "xsel -i --clipboard"
      bind -T copy-mode-vi C-c send -X copy-pipe-no-clear "xsel -i --clipboard"
      bind -T copy-mode    DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i"
      bind -T copy-mode-vi DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i"
      bind -n DoubleClick1Pane select-pane \; copy-mode -M \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i"
      bind -T copy-mode    TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i"
      bind -T copy-mode-vi TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i"
      bind -n TripleClick1Pane select-pane \; copy-mode -M \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i"
      bind -n MouseDown2Pane run "tmux set-buffer -b primary_selection \"$(xsel -o)\"; tmux paste-buffer -b primary_selection; tmux delete-buffer -b primary_selection"
    '';
  };
}
