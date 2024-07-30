{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.hyprshade
  ];
  cfg = {
    rofi.enable = true;
  };

  services.hyprshade = {
    enable = true;
    schedule = [
      {
        name = "blf";
        startTime = "20:00:00";
        endTime = "05:00:00";
      }
      # {
      #   name = "color-filter";
      #   startTime = "08:00:00";
      #   config = {
      #     type = "red-green";
      #     strength = 0.5;
      #   };
      # }
    ];
    additionalShades = {
      blf = builtins.readFile ./blue-light-filter.glsl.mustache;
    };
    systemd.enable = true;
  };

  programs.git.difftastic.enable = true;
  programs.git.delta.enable = pkgs.lib.mkForce false;

  home = {
    packages = with pkgs; [
      vscode-fhs
      obsidian
      calibre
      gnome.nautilus
      # taskwarrior
      keepassxc
      thunderbird
      brave
      okular
      tracker-miners
      gnome.dconf-editor
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
  };
}
