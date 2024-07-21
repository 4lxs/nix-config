_inputs: {
  lib,
  config,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.hack.enable {
    containers.hack = {
      privateNetwork = true;
      hostAddress = "192.168.100.2";
      localAddress = "192.168.100.11";

      forwardPorts = [
        {
          containerPort = 22;
          hostPort = 2222;
          protocol = "tcp";
        }
        {
          containerPort = 80;
          hostPort = 8080;
          protocol = "tcp";
        }
      ];

      bindMounts."/" = {
        hostPath = "/home/svl/Projects/hack";
        isReadOnly = false;
      };

      config = {
        boot.isContainer = true;

        environment = {
          shellInit = "export DISPLAY=$(ip route | grep default | cut -d' ' -f3):0";
          systemPackages = [
            pkgs.nmap
          ];
        };

        networking = {
          nat = {
            enable = true;
            internalInterfaces = ["ve-rednix"];
            externalInterface = "eth0";
          };
          useDHCP = false;
          hostName = "RedNix";
          firewall = {
            enable = true;
            allowPing = true;
            allowedTCPPorts = [];
          };
        };

        # nix config
        nix = {
          settings.extra-experimental-features = [
            "nix-command"
            "flakes"
          ];
        };

        # nixpkgs config
        nixpkgs.config = {
          allowUnfree = true;
          allowInsecurePredicate = p: true;
        };

        # services
        services = {
          getty.autologinUser = "rednix";

          openssh = {
            enable = true;
            settings.X11Forwarding = true;
          };

          avahi = {
            enable = true;
            browseDomains = [];
            wideArea = false;
            nssmdns4 = true;
          };

          unbound = {
            enable = true;
            settings.server = {};
          };
        };

        system.stateVersion = "23.11";

        # users
        users.users.rednix = {
          isNormalUser = true;
          uid = 1000;
          description = "RedNix container user";
          password = "rednix";
          extraGroups = ["wheel"];
        };
      };
    };
  };
}
