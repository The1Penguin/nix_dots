{ config, lib, pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-tuna
      obs-vaapi
      obs-vkcapture
      wlrobs
      obs-tuna
      obs-scale-to-sound
    ];
  };
}
