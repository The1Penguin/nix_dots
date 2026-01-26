{ config, lib, pkgs, ... }:

{

  catppuccin.mako.enable = false;
  services.mako = {
    package = pkgs.stable.mako;
    enable = true;
    settings = {
      anchor = "top-right";
      background-color = "#eff1f5";
      border-color = "#ea76cb";
      border-radius = 15;
      border-size = 2;
      default-timeout = 10000;
      font = "DokiDokiMono Nerd Font 14";
      format = "<i>%s</i>\\n%b";
      group-by = "summary";
      height = 200;
      layer = "overlay";
      margin = "20,20,0";
      markup = true;
      max-icon-size = 96;
      padding = "15,15,15";
      progress-color = "over #c6cad1";
      text-color = "#4c4f69";
      width = 450;
    };
  };
}
