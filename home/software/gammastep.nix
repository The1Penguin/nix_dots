{ config, lib, pkgs, ... }:

{

  services.gammastep = {
    enable = true;
    enableVerboseLogging = true;
    longitude = 57.708870;
    latitude = 11.974560;
  };
}
