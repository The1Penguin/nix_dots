{ config, lib, pkgs, ... }:

{
  imports = [
    ./services/media.nix
  ];

  users = {
    groups.media = {};
    users.media = { 
      isSystemUser = true;
      group = "media";
      extraGroups = [ "video" "jellyfin" ];
    };
  };
}
