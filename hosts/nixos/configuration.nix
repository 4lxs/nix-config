{
  inputs,
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Ljubljana";

  # Select internationalisation properties.
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

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "svl";

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  hardware.sensor.iio.enable = true;

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  services.tailscale.enable = true;

  services.syncthing = {
    enable = true;
    user = "svl";
    dataDir = "/home/svl";
    openDefaultPorts = true;
    cert = "${config.sops.secrets."syncthing/cert".path}";
    key = "${config.sops.secrets."syncthing/key".path}";
    settings = {
      devices = {
        "vps".id = "C3WMR3H-JW2I2BP-UP2PCLW-5KYZWKC-JKBFWOZ-GF3MDIL-LZGIHON-D3DWSQK";
      };
      folders = {
        "sync" = {
          id = "default";
          path = "/home/svl/.local/sync";
          devices = ["vps"];
          ignorePerms = true;
        };
        "media" = {
          id = "or5rx-ggkxr";
          path = "/home/svl/.local/media";
          devices = ["vps"];
          ignorePerms = true;
        };
        "zotero-storage" = {
          id = "6lwpa-cgq7b";
          path = "/home/svl/Zotero/storage/";
          devices = ["vps"];
          ignorePerms = true;
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

  imports = [inputs.sops-nix.nixosModules.sops];
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.keyFile = "/home/svl/.config/sops/age/keys.txt";
  sops.secrets."syncthing/cert" = {};
  sops.secrets."syncthing/key" = {};

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.defaultUserShell = pkgs.fish;
  users.users.svl = {
    isNormalUser = true;
    # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
    initialPassword = "00000";
    description = "Luka Svensek";
    extraGroups = ["networkmanager" "wheel"];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
