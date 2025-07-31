{
  lib,
  pkgs,
  outputs,
  host_config,
  inputs,
  ...
}: {
  imports = [
    # outputs.homeManagerModules.hyprshade
    inputs.nur.modules.homeManager.default
  ];

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    # matchBlocks = {
    #   "work" = {
    #     hostname = "192.168.10.125";
    #     user = "lukas";
    #   };
    #   "ultra" = {
    #     hostname = "svl.aero.usbx.me";
    #     user = "svl";
    #   };
    # };
  };

  # xdg.mimeApps.enable = true;

  programs.home-manager.enable = true;

  # Needed for virtualization
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

  dotx = {
    config = "dotx";
    user = {
      name = host_config.user;
      email = "66408983+4lxs@users.noreply.github.com";
    };

    # tmux = {
    #   enable = true;
    #   makeTerminalDefault = true;
    # };
    # zellij.enable = true;
    userDirs.enable = true;
  };

  programs.git.difftastic.enable = true;
  programs.git.delta.enable = pkgs.lib.mkForce false;
  programs.nix-your-shell.enable = true;

  home = {
    username = "${host_config.user}";
    homeDirectory = "/home/${host_config.user}";
    sessionPath =
      [
        "/home/svl/.config/emacs/bin"
        "/home/svl/.ghcup/bin"
        "/home/svl/.cabal/bin"
        "$HOME/.local/bin"
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        "/opt/local/bin"
        "/opt/local/sbin"
      ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      vscode-fhs
      # calibre
      # thunderbird
      # brave
      kdePackages.okular
      feh
      mpv
      helix
      yazi
      # emacsGcc
      qmk
      obsidian
      sops
      tridactyl-native
      chezmoi
      zotero
      nautilus-python
      wl-clipboard
      anki
      foliate
      rnote

      wqy_microhei
      noto-fonts-cjk-sans

      clang
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
