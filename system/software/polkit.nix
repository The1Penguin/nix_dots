{ config, lib, pkgs, ... }:

{
  security.polkit.enable = true;
  security.rtkit.enable = true;
}
