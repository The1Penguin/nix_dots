{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.gcr_4 ];
  services.gnome-keyring.enable = true;
}
