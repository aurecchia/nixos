{ inputs, pkgs, home, pkgs-unstable, ... }:

{
  programs.firefox = {
    enable = true;

    package = pkgs-unstable.firefox;

    nativeMessagingHosts = [
      pkgs.tridactyl-native
    ];

    profiles.auri = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        canvasblocker
        consent-o-matic
        dark-mode-website-switcher
        kagi-search
        privacy-badger
        refined-github
        stylus
        violentmonkey
        tridactyl
        ublock-origin
      ];

      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.chrome.guess_favicon" = false;
        "browser.compactmode.show" = true;
        "browser.disableResetPrompt" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.pinned" = "[]";
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.uidensity" = 1;

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

        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["jid1-mnnxcxisbpnsxq_jetpack-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","canvasblocker_kkapsner_de-browser-action","search_kagi_com-browser-action","_60f82f00-9ad5-4de5-b31c-b16a47c51558_-browser-action","gdpr_cavi_au_dk-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action","reset-pbm-toolbar-button","dark-mode-website-switcher_rugk_github_io-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","canvasblocker_kkapsner_de-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","search_kagi_com-browser-action","_60f82f00-9ad5-4de5-b31c-b16a47c51558_-browser-action","dark-mode-website-switcher_rugk_github_io-browser-action","gdpr_cavi_au_dk-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list","unified-extensions-area"],"currentVersion":20,"newElementCount":8}'';
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;

        "widget.non-native-theme.scrollbar.override" = 16;
        "widget.non-native-theme.scrollbar.styel" = 3;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
  
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  home.sessionVariables.BROWSER = "${pkgs.firefox}/bin/firefox";
}
