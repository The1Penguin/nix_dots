{ config, lib, pkgs, ... }:

{
  services.dbus = {
    enable = true;
    implementation = "broker";
  };
}
