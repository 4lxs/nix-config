{ inputs, outputs, lib, config, pkgs, ... }: {
    home.packages = with pkgs; [
        playerctl
    ];
    programs.waybar = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
        systemd.enable = true;
        style = ./style.css;
        settings = {
            primary = {
                layer = "top";
                modules-left = [
                    "custom/launcher"
                    "wlr/workspaces"
                ];
                modules-center = [];
                modules-right = [
                    "mpris"
                    "tray"
                    "idle_inhibitor"
                    "backlight"
                    "pulseaudio"
                    "network"
                    "battery"
                    "clock"
                    "custom/power"
                ];
                "custom/launcher" = {
                    format = "";
                    on-click = "${pkgs.rofi}/bin/rofi -show drun";
                };
                "wlr/workspaces" = {
                    format = "{icon}";
                    format-icons = {
                        "1" = "";
                        "2" = "";
                        "3" = "";
                        "4" = "";
                        "5" = "";
                    };
                    persistent_workspaces = {
                        "1" = []; "2" = []; "3" = []; "4" = []; "5" = [];
                    };
                    on-click = "activate";
                };
                mpris = {
                    format = "{player_icon} {status_icon} {title}";
                    on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
                    max-length = 25;
                    player-icons = {
                        mpv = "󰐍";
                        firefox = "󰈹";
                        spotify = " ";
                    };
                    status-icons = {
                        paused = "⏸";
                        playing = "󰐊";
                    };
                };
                tray = {
                    spacing = 10;
                };
                idle_inhibitor = {
                    format = "{icon}";
                    format-icons = {
                        activated = "";
                        deactivated = "";
                    };
                };
                backlight = {
                    format = "{percent}% {icon}";
                    on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+";
                    on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
                    format-icons = [ "" "" "" "" "" "" "" "" "" ];
                };
                battery = {
                    format = "{capacity}% {icon}";
                    format-charging = "{capacity}% 󰂄";
                    format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
                    format-plugged = "{capacity}% ";
                    format-time = "{H}h {M}min";
                    states = {
                        warning = 15;
                        critical = 5;
                    };
                };
                clock = {
                    format-alt = "{:%Y-%m-%d}";
                };
                network = {
                    format-alt = "{ifname}: {ipaddr}/{cidr}";
                    format-disconnected = "󰖪";
                    format-ethernet = "󰈀";
                    format-linked = "󰈁";
                    format-wifi = "{essid} ";
                    tooltip-format = "{ipaddr}";
                };
                position = "top";
                pulseaudio = {
                    format = "{volume}% {icon}";
                    format-bluetooth = "{volume}% {icon}";
                    format-bluetooth-muted = " {icon}";
                    format-icons = {
                        car = "";
                        default = [ "" "" "" ];
                        hands-free = "󱡏";
                        headphone = "";
                        headset = "󰋎";
                        phone = "";
                        portable = "";
                    };
                    format-muted = "󰖁";
                    on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
                };
                "custom/power" = {
                    format = "";
                    on-click = "poweroff";
                };
            };
        };
    };
}