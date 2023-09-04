{ inputs, lib, config, pkgs, ... }: { # alacritty config
  programs.alacritty = {
    enable = true;
    settings = {
      scrolling.history = 0;
      dynamic_title = true;
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
        args = [ "new" "-AsMain" ];
      };

      key_bindings = [
      { key = 1; mods = "Control"; chars = "\x14\x30"; }
      { key = 2; mods = "Control"; chars = "\x14\x31"; }
      { key = 3; mods = "Control"; chars = "\x14\x32"; }
      { key = 4; mods = "Control"; chars = "\x14\x33"; }
      { key = 5; mods = "Control"; chars = "\x14\x34"; }
      { key = 6; mods = "Control"; chars = "\x14\x35"; }
      { key = 7; mods = "Control"; chars = "\x14\x36"; }
      { key = 8; mods = "Control"; chars = "\x14\x37"; }
      { key = 9; mods = "Control"; chars = "\x14\x38"; }
      ];

      # TokyoNight Alacritty Colors
      colors = {
        primary = {
          background = "0x1a1b26";
            foreground = "0xc0caf5";
        };
        normal = {
          black = "0x15161e";
            red = "0xf7768e";
            green = "0x9ece6a";
            yellow = "0xe0af68";
            blue = "0x7aa2f7";
            magenta = "0xbb9af7";
            cyan = "0x7dcfff";
            white = "0xa9b1d6";
        };
        bright = {
          black = "0x414868";
            red = "0xf7768e";
            green = "0x9ece6a";
            yellow = "0xe0af68";
            blue = "0x7aa2f7";
            magenta = "0xbb9af7";
            cyan = "0x7dcfff";
            white = "0xc0caf5";
        };
        indexed_colors = [
        { index = 16; color = "0xff9e64"; }
        { index = 17; color = "0xdb4b4b"; }
        ];
      };
      env.TERM = "xterm-256color";
    };
  };
                                    }
