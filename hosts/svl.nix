{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
    ./svl-hardware-configuration.nix
    ./features/vm.nix
    # ./features/hax
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
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

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.stable.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
      };
      # systemd-boot.enable = true;
      grub = {
        # setup bootloader
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
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

  programs.kdeconnect.enable = true;

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
  services.transmission.enable = true;
  services.tlp = {
    enable = true;
  };


  services.udisks2.enable = true;

  services.ntp.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
