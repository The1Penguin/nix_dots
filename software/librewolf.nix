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
      search = {
        engines = {
          "Acorneroftheweb.com" = {
            urls = [{
              template = "https://search.acorneroftheweb.com/search?q={searchTerms}";
            }];
          };

          "Google".metaData.hidden = true;
          "DuckDuckGo Lite".metaData.hidden = true;
          "Meta Ger".metaData.hidden = true;
          "Mojeek".metaData.hidden = true;
          "SearXNG - searx.be".metaData.hidden = true;
          "StartPage".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
        default = "Acorneroftheweb.com";
        force = true;
      };
    };
  };
}
