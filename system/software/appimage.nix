{ config, lib, pkgs, ... }:

{
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}
