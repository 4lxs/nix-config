{
  cfg = {
    nixColors.enable = true;
    alacritty.enable = true;
    sops = {
      enable = true;
      file = ./secrets.yaml;
      secrets = [
        "ssh/id_ed25519_privkey"
        "ssh/rsa_privkey"
      ];
    };
  };

  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";
  };
}
