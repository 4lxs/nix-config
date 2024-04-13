{
  lib,
  pkgs,
  config,
  ...
}:
let
  noTmuxEntry = pkgs.makeDesktopItem {
    name = "alacritty";
    desktopName = "Alacritty (no tmux)";
    exec = "alacritty -e zsh";
    icon = "Alacritty";
    terminal = false;
  };
in
{
  options.cfg.alacritty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable alacritty terminal emulator";
    };
  };
  config = lib.mkIf config.cfg.alacritty.enable {
    home.packages = [ noTmuxEntry ];

    programs.alacritty = {
      enable = true;
      settings = {
        scrolling.history = 0;
        # dynamic_title = true;
        font = {
          normal.family = "FiraCode Nerd Font Mono";
          size = 12;
        };

        window = {
          opacity = 0.95;
          dynamic_padding = true;
        };

        cursor.style.shape = "Beam";
        shell = {
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "new"
            "-AsMain"
          ];
        };

        #      key_bindings = [
        #        { key = 1; mods = "Control"; chars = "\x14\x30"; }
        #        { key = 2; mods = "Control"; chars = "\x14\x31"; }
        #        { key = 3; mods = "Control"; chars = "\x14\x32"; }
        #        { key = 4; mods = "Control"; chars = "\x14\x33"; }
        #        { key = 5; mods = "Control"; chars = "\x14\x34"; }
        #        { key = 6; mods = "Control"; chars = "\x14\x35"; }
        #        { key = 7; mods = "Control"; chars = "\x14\x36"; }
        #        { key = 8; mods = "Control"; chars = "\x14\x37"; }
        #        { key = 9; mods = "Control"; chars = "\x14\x38"; }
        #      ];

        colors =
          if config.cfg.nixColors.enable then
            let
              col = config.colorScheme.palette;
            in
            {
              primary = {
                background = "0x${col.base00}";
                foreground = "0x${col.base05}";
              };
              normal = {
                black = "0x${col.base01}";
                red = "0x${col.base08}";
                green = "0x${col.base0B}";
                yellow = "0x${col.base0A}";
                blue = "0x${col.base0D}";
                magenta = "0x${col.base0E}";
                cyan = "0x${col.base0C}";
                white = "0x${col.base05}";
              };
              bright = {
                black = "0x${col.base03}";
                red = "0x${col.base08}";
                green = "0x${col.base0B}";
                yellow = "0x${col.base0A}";
                blue = "0x${col.base0D}";
                magenta = "0x${col.base0E}";
                cyan = "0x${col.base0C}";
                white = "0x${col.base07}";
              };
            }
          else
            {
              # tokyonight
              primary = {
                background = "0x1a1b26";
                foreground = "0xa9b1d6";
              };
              normal = {
                black = "0x32344a";
                red = "0xf7768e";
                green = "0x9ece6a";
                yellow = "0xe0af68";
                blue = "0x7aa2f7";
                magenta = "0xad8ee6";
                cyan = "0x449dab";
                white = "0x787c99";
              };
              bright = {
                black = "0x444b6a";
                red = "0xff7a93";
                green = "0xb9f27c";
                yellow = "0xff9e64";
                blue = "0x7da6ff";
                magenta = "0xbb9af7";
                cyan = "0x0db9d7";
                white = "0xacb0d0";
              };
            };
        env.TERM = "tmux-256color";
      };
    };
  };
}