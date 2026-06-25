{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pulseaudio
    pulsemixer
    pavucontrol
  ];
}
