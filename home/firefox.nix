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
        kagi-search
        consent-o-matic
      ];

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";

        "browser.search.separatePrivateDefault" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;

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

        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","canvasblocker_kkapsner_de-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action","reset-pbm-toolbar-button","jid1-mnnxcxisbpnsxq_jetpack-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","canvasblocker_kkapsner_de-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list","unified-extensions-area"],"currentVersion":20,"newElementCount":6}'';
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
