{ config, lib, pkgs, ... }:

{
  services.audiobookshelf = {
    enable = true;
    port = 8000;
    group = "media";
    user = "media";
  };
}
