_inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
  noTmuxEntry = pkgs.makeDesktopItem {
    name = "alacritty";
    desktopName = "Alacritty (no tmux)";
    exec = "alacritty -e fish";
    icon = "Alacritty";
    terminal = false;
  };
in {
  config = mkIf libx.cfg.alacritty.enable {
    home.packages =
      if libx.cfg.alacritty.openTmux
      then [noTmuxEntry]
      else [];

    programs.alacritty = {
      enable = true;

      settings = {
        scrolling.history = 0;
        # dynamic_title = true;
        env.TERM = "tmux-256color";

        # font = with libx.cfg.theme.font; {
        #   normal = {
        #     family = monospace.name;
        #     style = "Regular";
        #   };
        #   size = size.terminal;
        # };
        #
        window = {
          opacity = libx.cfg.theme.transparency;
          dynamic_padding = true;
        };

        cursor.style.shape = "Beam";
        shell = mkIf libx.cfg.alacritty.openTmux {
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "new"
            "-AsMain"
          ];
        };

        # colors = with libx.cfg.theme.base16.withHashtag; {
        #   primary = {
        #     foreground = base05;
        #     background = base00;
        #     bright_foreground = base07;
        #   };
        #   selection = {
        #     text = base05;
        #     background = base02;
        #   };
        #   cursor = {
        #     text = base00;
        #     cursor = base05;
        #   };
        #   normal = {
        #     black = base00;
        #     white = base05;
        #     inherit
        #       red
        #       green
        #       yellow
        #       blue
        #       magenta
        #       cyan
        #       ;
        #   };
        #   bright = {
        #     black = base03;
        #     white = base07;
        #     red = bright-red;
        #     green = bright-green;
        #     inherit yellow;
        #     blue = bright-blue;
        #     magenta = bright-magenta;
        #     cyan = bright-cyan;
        #   };
        # };
      };
    };
  };
}
