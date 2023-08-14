{ inputs, outputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    sddm-themes.sugar-dark
  ];

  # TODO: custom sddm package for wayland only
  services.xserver.enable = true;
  services.xserver.displayManager = {
    sessionPackages = [
      (inputs.hyprland.packages.${pkgs.system}.default.overrideAttrs
        (prevAttrs: rec {
          postInstall =
            let
              hyprSession = ''
                [Desktop Entry]
                Name=Hyprland
                Comment=An intelligent dynamic tiling Wayland compositor
                Exec=Hyprland
                Type=Application
              '';
            in
            ''
              mkdir -p $out/share/wayland-sessions
              echo "${hyprSession}" > $out/share/wayland-sessions/hyprland.desktop
            '';
          passthru.providedSessions = [ "hyprland" ];
        })  
      )
    ];
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      settings = {
        General = {
          DisplayServer = "wayland";
          GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        };
      };
      theme = "sddm-sugar-dark";
    };
  };

}