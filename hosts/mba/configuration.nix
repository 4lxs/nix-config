{ config, apple-silicon, lib, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../features/apple-silicon-support
      ../common.nix
      ../../common
      # ../features/sddm
      # ../features/vm.nix
      # ../features/hax
    ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  hardware.asahi.useExperimentalGPUDriver = true;
  # nixpkgs.overlays = [ apple-silicon.overlays.apple-silicon-overlay ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfiguration = true;
  # };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };



  networking = {
    hostName = "mba";
    networkmanager.enable = true;
    hosts = {
      "192.168.10.70" = [ "gitlab.eba.si" ];
      "192.168.10.125" = [ "work" ];
    };
  };
  programs.nm-applet.enable = true;

  # localization
  time.timeZone = "Europe/Ljubljana";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sl_SI.UTF-8";
    LC_IDENTIFICATION = "sl_SI.UTF-8";
    LC_MEASUREMENT = "sl_SI.UTF-8";
    LC_MONETARY = "sl_SI.UTF-8";
    LC_NAME = "sl_SI.UTF-8";
    LC_NUMERIC = "sl_SI.UTF-8";
    LC_PAPER = "sl_SI.UTF-8";
    LC_TELEPHONE = "sl_SI.UTF-8";
    LC_TIME = "sl_SI.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;
  users.users = {
    svl = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      initialPassword = "00000";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "networkmanager" "audio" ];
    };
  };

  # programs.kdeconnect.enable = true;

  console.useXkbConfig = true; # console use same layout as xkb
  # auto upgrade system
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  hardware.opengl.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
  # services.transmission.enable = true;
  # services.tlp = {
  #   enable = true;
  # };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';


  # services.udisks2.enable = true;

  services.ntp.enable = true;

  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = false;
  # };

  # services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };



  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}

