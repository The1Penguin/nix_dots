{ config, lib, pkgs, ... }:

{
  home.file = {
    ".config/wireplumber/wireplumber.conf.d/50-bluez.conf".source = ../files/bluez;
  };
}
