{ config, lib, pkgs, Betterfox, ... }:

{
  programs.librewolf = {
    enable = true;
    profiles.pingu = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        betterttv
        bitwarden
        consent-o-matic
        dearrow
        enhancer-for-youtube
        firefox-color
        foxyproxy-standard
        new-tab-override
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
      ];
      isDefault = true;
      userChrome = (builtins.readFile ../files/firefox.css);
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
      extraConfig = (builtins.readFile "${Betterfox}/user.js");
    };
  };
}
