{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];

  options.cfg.appleSilicon = {
    enable = lib.mkEnableOption "enable apple silicon support";
  };

  config = lib.mkIf config.cfg.appleSilicon.enable {
    nixpkgs.overlays = [ inputs.apple-silicon.overlays.apple-silicon-overlay ];

    # fn lock: see https://wiki.archlinux.org/title/Apple_Keyboard#Function_keys_do_not_work
    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';

    hardware.asahi.useExperimentalGPUDriver = true;
  };
}
