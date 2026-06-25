{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.bitwarden-desktop ];
}
