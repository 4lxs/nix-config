_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block

        [ -f ~/.cargo/env.fish ] && source ~/.cargo/env.fish

        function fish_user_key_bindings
          # Execute this once per mode that emacs bindings should be used in
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
        end

        function y
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        end
      '';
    };
  };
}
