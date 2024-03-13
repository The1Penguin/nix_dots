{ config, lib, pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "latte";

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
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
