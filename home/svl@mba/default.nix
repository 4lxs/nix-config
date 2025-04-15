{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    # outputs.homeManagerModules.hyprshade
  ];
  dotx = {
    config = "dotx";
    user = {
      name = "svl";
      email = "66408983+4lxs@users.noreply.github.com";
    };

    git.enable = true;
    zathura.enable = true;
    # tmux = {
    #   enable = true;
    #   makeTerminalDefault = true;
    # };
    zellij.enable = true;
    # kdeconnect.enable = true;
  };

  programs.git.difftastic.enable = true;
  programs.git.delta.enable = pkgs.lib.mkForce false;
  programs.nix-your-shell.enable = true;

  home = {
    sessionPath = ["/home/svl/.config/emacs/bin" "/home/svl/.ghcup/bin" "/home/svl/.cabal/bin"];
    packages = with pkgs; [
      vscode-fhs
      calibre
      thunderbird
      brave
      kdePackages.okular
      feh
      mpv
      helix
      yazi
      # emacsGcc
      clang-tools
      qmk
      syncthing
      obsidian
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };
}
