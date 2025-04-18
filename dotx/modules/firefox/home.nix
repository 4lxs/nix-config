{nur, ...}: {
  pkgs,
  lib,
  config,
  host_config,
  ...
}: 
with lib; let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.firefox.enable {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [ pkgs.tridactyl-native ];
      profiles."${libx.cfg.firefox.user}" = {
        name = libx.cfg.firefox.user;

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          tridactyl
          zotero-connector

          (pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
            pname = "bypass-paywalls-clean";
            version = "latest";
            addonId = "magnolia@12.34";
            url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-latest.xpi";
            sha256 = "sha256-VIcHif8gA+11oL5AsADaHA6qfWT8+S0A8msaYE2ivns=";
            meta = with lib; {
              homepage = "https://twitter.com/Magnolia1234B";
              description = "Bypass Paywalls of (custom) news sites";
              license = licenses.mit;
              platforms = platforms.all;
            };
          })
        ];
        # userChrome = let
        #   chromeFiles = builtins.attrNames (builtins.readDir ./chrome);
        # in
        #   lib.concatStrings (map (fn: builtins.readFile (./chrome + ("/" + fn))) chromeFiles);
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.aboutwelcome.enabled" = false;
          "browser.newtabpage.enabled" = false;
          "browser.startup.page" = 3;
          "browser.download.dir" = config.xdg.userDirs.download;
          "browser.toolbars.bookmarks.visibility" = "never";
          "sidebar.verticalTabs" = true;
          "signon.autofillForms" = false;
          # this is to auto enable extensions. but it doesn't work well and
          # still need to disable/reenable them to get them working
          # "extensions.autoDisableScopes" = 0;
        };
        # # see https://ffprofile.com/
        # extraConfig = builtins.readFile ./prefs.js;
      };
      policies = {
      #   NewTabPage = false;
        DisplayMenuBar = false;
        DisableFormHistory = true;
      #   # DisableFirefoxAccounts = true;
      #   DisableBuiltinPDFViewer = true;
        NetworkPrediction = false;
        CaptivePortal = false;
        DNSOverHTTPS.Enabled = false;
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DisablePocket = true;
      #   OverrideFirstRunPage = "";
      #   OverridePostUpdatePage = "";
      };
    };
  };
}
