{ config, lib, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Monaspace Neon NF:size=16";
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
