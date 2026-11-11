{ config, lib, pkgs, ... }:

{
  programs.solaar = {
    enable = true;
    userService.enable = true;
  };
}
