{
  pkgs,
  host_config,
  lib,
  config,
  ...
}: {
  options.cfg.nixosHost = {
    enable = lib.mkEnableOption "enable nixos host configuration";
  };

  config = lib.mkIf config.cfg.nixosHost.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = false;
        grub = {
          efiSupport = true;
          #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
          device = "nodev";
        };

        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        timeout = 0;
      };
      initrd.systemd.enable = true;
      plymouth = {
        enable = true;
        theme = "connect";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["connect"];
          })
        ];
      };

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    networking = {
      hostName = host_config.host;
      networkmanager.enable = true;
      hosts = {
        "192.168.10.70" = ["gitlab.eba.si"];
        "192.168.10.125" = ["work"];
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

    users = {
      defaultUserShell = pkgs.fish;
      users = {
        "${host_config.user}" = {
          # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
          initialPassword = "00000";
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "docker"
            "networkmanager"
            "audio"
          ];
        };
      };
    };

    console.useXkbConfig = true; # console use same layout as xkb
    # auto upgrade system
    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = true;

    hardware.opengl.enable = true;

    security.polkit.enable = true;
    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true;
      };
      blueman.enable = true;

      # transmission.enable = true;
      # tlp = {
      #   enable = true;
      # };
      logind.extraConfig = ''
        # don’t shutdown when power button is short-pressed
        HandlePowerKey=ignore
      '';

      # services.udisks2.enable = true;

      ntp.enable = true;
    };
    hardware.bluetooth.enable = true;
    environment.systemPackages = with pkgs; [pavucontrol];

    # virtualisation.docker = {
    #   enable = true;
    #   enableOnBoot = false;
    # };
  };
}
