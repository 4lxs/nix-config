{ pkgs, inputs, outputs, ... }: {
  imports = [
    ./common.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;
  # nix.package = pkgs.nixUnstable;

  homebrew = {
    enable = true;
    casks = [
      "brave-browser"
      "amethyst"
    ];
  };

  users.users."lukas".home = "/Users/lukas/";

  time.timeZone = "Europe/Ljubljana";

  system = {
    stateVersion = 4;

    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2;

        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        "com.apple.swipescrolldirection" = false;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 48;
        mru-spaces = false;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingSrc = 30064771296; # lctl
          HIDKeyboardModifierMappingDst = 30064771299; # lcmd
        }
        {
          HIDKeyboardModifierMappingSrc = 30064771299; # lcmd
          HIDKeyboardModifierMappingDst = 30064771296; # lctl
        }
        {
          HIDKeyboardModifierMappingSrc = 30064771303; # rcmd
          HIDKeyboardModifierMappingDst = 30064771302; # ropt
        }
        {
          HIDKeyboardModifierMappingSrc = 30064771302; # ropt
          HIDKeyboardModifierMappingDst = 30064771303; # rcmd
        }
      ];
    };
  };

  # Following line should allow us to avoid a logout/login cycle
  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
