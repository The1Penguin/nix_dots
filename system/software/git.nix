{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    git-crypt
  ];
}
