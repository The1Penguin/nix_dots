{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.stable.kotatogram-desktop ];
}
