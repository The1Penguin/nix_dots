{ config, lib, pkgs, ... }:

{
  programs.fish.enable = true;
  environment.pathsToLink = [ "/share/fish" ];
}
