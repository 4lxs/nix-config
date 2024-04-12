{ config, ... }:
{
  # home.packages = with pkgs; [ firefox ];
  programs.firefox = {
    enable = true;
    profiles.svl = {
      name = "svl";
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
        bypass-paywalls-clean
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
}
