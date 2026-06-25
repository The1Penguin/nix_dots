{ config, lib, pkgs, defaultSession, ... }:

{
  services.displayManager = {
    defaultSession = defaultSession;
    sddm = {
      enable = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
    };
  };
}
