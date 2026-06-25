{ config, lib, pkgs, ... }:

{
  services.power-profiles-daemon.enable = lib.mkForce false;
}
