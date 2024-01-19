{ inputs, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.auri = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        canvasblocker
        privacy-badger
        refined-github
        tridactyl
        ublock-origin
      ];

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";

        "browser.urlbar.suggest.bookmarks" = true;
        "browser.urlbar.suggest.engines" = true;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.openpage" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.suggest.topsites" = false;

        "general.smoothScroll" = true;
        "general.smoothScroll.currentVelocityWeighting" = "0.1";
        "general.smoothScroll.mouseWheel.durationMaxMS" = 250;
        "general.smoothScroll.mouseWheel.durationMinMS" = 125;
        "general.smoothScroll.stopDecelerationWeighting" = "0.7";
        "mousewheel.min_line_scroll_amount" = 25;
        "apz.overscroll.enabled" = true; # elastic overscroll

        "browser.sessionstore.restore_on_demand" = true;
        "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
        "browser.sessionstore.restore_tabs_lazily" = true;

        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
