{config, ...}: let
  libx = config.lib.dotx;
in
  with libx.options; {
    options.dotx = {
      dotx-shell = mkTarget ''
        gtk shell widgets
      '';

      zathura = mkTarget "zathura document viewer";

      alacritty =
        mkTarget "alacritty terminal emulator"
        // {
          openTmux = mkBool libx.cfg.tmux.makeTerminalDefault ''
            make default program tmux and add a desktop entry without tmux for
            special cases
          '';
        };

      anyrun = mkTarget "anyrun";

      dunst = mkTarget "dunst notification daemon";

      fish = mkTarget "fish shell";

      fontconfig = mkTarget ''fonts configuration'';

      gtk = mkTarget "gtk theming";

      hyprland = mkTarget "hyprland window manager";

      kde = mkTarget "kde theming";

      kdeconnect = mkTarget "kdeconnect";

      kitty = mkTarget "kitty terminal emulator";

      mako = mkTarget "mako notification daemon";

      rofi = mkTarget "rofi";

      shell = {
        utils = mkTarget "better shell utils";
        aliases =
          mkTarget "helpful shell aliases" // {
            git = mkBool libx.cfg.shell.aliases.enable "helpful git aliases";
          };
      };

      firefox = mkTarget "firefox browser" // {
          user = mkStr "firefox profile username";
        };

      starship = mkTarget "starship prompt";

      tmux =
        mkTarget "tmux"
        // {
          makeTerminalDefault = mkEnable ''
            make terminals open tmux by default and add a special no tmux desktop entry
            for special cases
          '';
        };

      zellij = mkTarget "zellij";

      userDirs = mkTarget ''
        Use my custom directories for user directories.
        that is Downloads/Limbo for the download directory.
      '';

      waybar = mkTarget "waybar";

      git =
        mkTarget "git"
        // {
          aliases = mkDisable ''
            dotx git aliases
          '';
        };

      hack = mkTarget "hack";

      lazygit = mkTarget "lazygit";
    };
  }
