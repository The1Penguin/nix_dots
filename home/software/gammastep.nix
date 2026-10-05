{ config, lib, pkgs, ... }:

{
  services.gammastep = {
    enable = true;
    enableVerboseLogging = true;
    longitude = 59.858550;
    latitude = 17.638904;
  };
}
