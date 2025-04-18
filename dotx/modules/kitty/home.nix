_inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
  noTmuxEntry = pkgs.makeDesktopItem {
    name = "kitty-notmux";
    desktopName = "Kitty (no tmux)";
    exec = "kitty -e fish";
    icon = "kitty";
    terminal = false;
  };
  # theme = libx.cfg.theme.base16 {
  #   templateRepo = libx.templates.kitty;
  #   target = "default-256";
  # };
in {
  config = lib.mkIf libx.cfg.kitty.enable {
    # home.packages = [noTmuxEntry];
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;

      font = with libx.cfg.theme.font; {
        inherit (monospace) name package;
        size = size.terminal;
      };
      settings = {
        # shell = "${pkgs.tmux}/bin/tmux new -AsMain";
        # shell = "${pkgs.zellij}/bin/zellij";
        # term = "tmux-256color";
        background_opacity = builtins.toString libx.cfg.theme.transparency;
        confirm_os_window_close = 0;
        cursor_shape = "beam";
        hide_window_decorations = true;
        enabled_layouts = "tall:bias=50;full_size=1;mirrored=false,stack";
      };
      extraConfig = ''
        map ctrl+backspace send_text all \x17
        map f1 launch --cwd=current

        map ctrl+left kitten pass_keys.py neighboring_window left   ctrl+left
        map ctrl+down kitten pass_keys.py neighboring_window bottom ctrl+down
        map ctrl+up kitten pass_keys.py neighboring_window top    ctrl+up
        map ctrl+right kitten pass_keys.py neighboring_window right  ctrl+right
        map kitty_mod+f toggle_layout stack

        # kitty-navigator.nvim
        allow_remote_control yes
        listen_on unix:@mykitty
      '';
    };
  };
}
