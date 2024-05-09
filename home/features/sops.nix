{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  options.cfg.sops = {
    enable = lib.mkEnableOption "Enable sops";

    # FIXME: doesn't work
    file = lib.mkOption {
      type = lib.types.path;
      default = ../.../../secrets.yaml;
      description = "The default sops file";
    };
    secrets = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
      description = "additional secrets to get from cfg.sops.file";
    };
  };

  config = lib.mkIf config.cfg.sops.enable {
    home.packages = with pkgs; [
      sops
      age
      ssh-to-age
    ];

    sops = {
      age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      defaultSopsFile = config.cfg.sops.file;
      secrets = let
        mkSecrets = sopsFile: secrets:
          lib.mkMerge (
            map (secret: {
              "${secret}" = {
                path = "%r/${secret}.txt";
                inherit sopsFile;
              };
            })
            secrets
          );
      in
        mkSecrets ../../secrets.yaml ["wifi/password"]
        // mkSecrets config.cfg.sops.file config.cfg.sops.secrets;
    };

    # home.activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    #   /run/current-system/sw/bin/systemctl start --user sops-nix
    # '';
  };
}
