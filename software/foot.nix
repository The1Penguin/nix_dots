{ config, lib, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "DokiDokiMono Nerd Font:size=16";
        pad = "5x3";
      };
      colors = {
        alpha = 0.93;
      };
    };
  };
}
