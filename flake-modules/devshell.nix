{
  # imports = [inputs.devshell.flakeModule];

  perSystem = {
    self',
    system,
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = [pkgs.convco pkgs.alejandra pkgs.pre-commit];
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
    # devshells.default = {
    #   devshell.startup.pre-commit.text = config.pre-commit.installationScript;
    #
    #   packages = with pkgs; [convco alejandra];
    #
    #   commands = [
    #     {
    #       name = "format";
    #       help = "format the codebase";
    #       command = "nix fmt";
    #     }
    #   ];
    # };
  };
}
