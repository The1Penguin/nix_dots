{ config, lib, pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.pingu = {
      isDefault = true;
      userChrome = (builtins.readFile ../files/firefox.css);
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };
}
