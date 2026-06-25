{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.playerctl ];
}
