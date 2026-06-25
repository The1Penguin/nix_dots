{ config, lib, pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "latte";

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      trashbin
      fullAlbumDate
      history
      powerBar
      playlistIcons
      fullAppDisplayMod
    ];
  };
}
