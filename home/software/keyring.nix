{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.gcr ];
  services.gnome-keyring.enable = true;
}
