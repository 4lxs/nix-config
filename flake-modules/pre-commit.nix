{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];
  perSystem = {
    config,
    system,
    ...
  }: {
    pre-commit = {
      settings.hooks = {
        # convco.enable = true;
        statix.enable = true;
        alejandra = {
          enable = true;
        };
      };
    };
  };
}
