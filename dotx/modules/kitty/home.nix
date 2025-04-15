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
    home.packages = [noTmuxEntry];
    programs.kitty = {
      enable = true;
      package = pkgs.hello; # broken

      font = with libx.cfg.theme.font; {
        inherit (monospace) name package;
        size = size.terminal;
      };
      settings = {
        # shell = "${pkgs.tmux}/bin/tmux new -AsMain";
        shell = "${pkgs.zellij}/bin/zellij";
        # term = "tmux-256color";
        background_opacity = builtins.toString libx.cfg.theme.transparency;
        confirm_os_window_close = 0;
        cursor_shape = "beam";
        scrollback_lines = 0;
      };
      extraConfig = ''
        map ctrl+backspace send_text all \x17
      '';
    };
  };
}
