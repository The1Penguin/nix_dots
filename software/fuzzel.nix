{ config, lib, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "DokiDokiMono Nerd Font:size=18";
        icons-enabled = false;
        layer = "overlay";
        vertical-pad = 10;
        inner-pad = 10;
        dpi-aware = "no";
      };
      border = {
        width = 2;
        radius = 10;
      };
    };
  };
}
