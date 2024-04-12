{ inputs, ... }:
{
  imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];

  nixpkgs.overlays = [ inputs.apple-silicon.overlays.apple-silicon-overlay ];

  # fn lock: see https://wiki.archlinux.org/title/Apple_Keyboard#Function_keys_do_not_work
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  hardware.asahi.useExperimentalGPUDriver = true;
}
