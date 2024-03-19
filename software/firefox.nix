{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.pingu = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        betterttv
        bypass-paywalls-clean
        consent-o-matic
        # clickbait-remover-for-youtube
        darkreader
        duckduckgo-privacy-essentials
        enhancer-for-youtube
        firefox-color
        foxyproxy-standard
        # jiffy-reader
        new-tab-override
        # new-xkit
        old-reddit-redirect
        privacy-badger
        reddit-enhancement-suite
        refined-github
        sidebery
        sponsorblock
        stylus
        tampermonkey
        ublock-origin
        vimium
        dearrow
      ];
      isDefault = true;
      userChrome = (builtins.readFile ../files/firefox.css);
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };
}
