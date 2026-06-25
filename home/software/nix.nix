{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nurl
    any-nix-shell
    nix-output-monitor
  ];
}
