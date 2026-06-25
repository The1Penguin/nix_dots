{ config, lib, pkgs, ... }:

{
  imports = [
    ../hardware/tkey.nix
  ];
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };
}
