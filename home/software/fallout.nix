{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    fallout-ce
    fallout2-ce
  ];
}
