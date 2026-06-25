{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.krdc
    remmina
  ];
}
