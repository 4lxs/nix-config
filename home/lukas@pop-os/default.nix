{ modules, ... }: {
  imports = [ modules.common modules.nixpkgs ];

  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";
  };
}
