{ config, lib, pkgs, ... }:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
  };
}
