{ pkgs, ... }: {
  # alacritty config
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

      colors = {
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
      env.TERM = "xterm-256color";
    };
  };
}
