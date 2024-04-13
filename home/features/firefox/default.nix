{
  lib,
  config,
  host_config,
  ...
}:
{
  options.cfg.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable firefox browser";
    };
    user = lib.mkOption {
      type = lib.types.str;
      default = host_config.user;
    };
  };

  config = lib.mkIf config.cfg.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles."${config.cfg.firefox.user}" = {
        name = config.cfg.firefox.user;
        userChrome = builtins.readFile ./userChrome.css;
        extensions = with config.nur.repos.rycee.firefox-addons; [
          bitwarden
          sidebery
          darkreader
          ublock-origin
          wikiwand-wikipedia-modernized
          enhancer-for-youtube
          floccus
          dearrow
          sponsorblock
          boring-rss
          canvasblocker
          # bypass-paywalls-clean
          competitive-companion
        ];
        # results in file in way constantly
        # search = {
        #   default = "Brave";
        #   engines = {
        #     "Brave" = {
        #       urls = [{
        #         template = "https://search.brave.com/search?q={searchTerms}";
        #       }];
        #     };
        #   };
        # };
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.aboutwelcome.enabled" = false;
          "browser.newtabpage.enabled" = false;
          "browser.startup.page" = 3;
          "browser.download.dir" = config.xdg.userDirs.download;
          "browser.toolbars.bookmarks.visibility" = "never";
        };
        # see https://ffprofile.com/
        extraConfig = builtins.readFile ./prefs.js;
      };
      policies = {
        NewTabPage = false;
        DisplayMenuBar = false;
        DisableFormHistory = true;
        DisableFirefoxAccounts = true;
        DisableBuiltinPDFViewer = true;
        NetworkPrediction = false;
        CaptivePortal = false;
        DNSOverHTTPS = {
          Enabled = false;
        };
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DisablePocket = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
      };
    };
  };
}
