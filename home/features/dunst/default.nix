{ inputs, outputs, lib, config, pkgs, ... }: {
    services.dunst = {
        enable = true;
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
            size = "64x64";
        };

        settings = {
            global = {
                follow = "mouse";
                indicate_hidden = "yes";

                offset = "10x10";

                # notification_height = 0;

                separator_height = 2;

                padding = 8;
                horizontal_padding = 8;
                text_icon_padding = 0;
                frame_width = 2;

                frame_color = "#89B4FA";
                separator_color = "frame";

                sort = "yes";
                idle_threshold = 120;
                font = "FiraCode Nerd Font 12";
                line_height = 0;
                markup = "full";
                alignment = "left";
                vertical_alignment = "center";
                show_age_threshold = 60;
                word_wrap = "yes";
                stack_duplicates = true;
                hide_duplicate_count = false;

                show_indicators = "yes";

                min_icon_size = 0;
                max_icon_size = 64;

                dmenu = "${pkgs.rofi-wayland}/bin/rofi -dmenu";
                browser = "/usr/bin/firefox --new-tab";

                title = "Dunst";
                class = "Dunst";

                corner_radius = 10;
                timeout = 5;
            };

            urgency_low = {
                background = "#1E1E2E";
                foreground = "#CDD6F4";
            };

            urgency_normal = {
                background = "#1E1E2E";
                foreground = "#CDD6F4";
            };

            urgency_critical = {
                background = "#1E1E2E";
                foreground = "#CDD6F4";
                frame_color = "#FAB387";
            };
        };
    };
}