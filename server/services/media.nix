{ config, lib, pkgs, ... }:

{
  services.flaresolverr.enable = true;
  services.prowlarr = {
    enable = true;
  };
  services.radarr = {
    enable = true;
    group = "media";
    user = "media";
  };
  services.sonarr = {
    enable = true;
    group = "media";
    user = "media";
  };
  services.audiobookshelf = {
    enable = true;
    port = 8000;
    host = "0.0.0.0";
    openFirewall = true;
    group = "media";
    user = "media";
  };
}
