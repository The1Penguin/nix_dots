{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (lutris.override {
      extraLibraries = pkgs: [
        libnghttp2
        pcre
      ];
      extraPkgs = lutrisPkgs: [
        wine64
        wineWow64Packages.waylandFull
        winetricks
        wget
        p7zip
        protontricks
        pkgs.zenity
        gamemode
      ];
    })
  ];
}
