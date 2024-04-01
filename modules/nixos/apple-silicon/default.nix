{ inputs, ... }: {
  imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];

  hardware.asahi.useExperimentalGPUDriver = true;
}
