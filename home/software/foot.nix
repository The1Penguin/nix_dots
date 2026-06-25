{ config, lib, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Monaspace Neon NF:size=14";
        pad = "5x3";
      };
      colors = {
        alpha = 0.93;
      };
    };
  };
}
