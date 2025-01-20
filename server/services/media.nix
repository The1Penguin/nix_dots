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
}
