{ config, lib, pkgs, ... }:

{
  imports = [
    ./services/audiobookshelf.nix
  ];

  users.users.media.extraGroups =  [ "video" "jellyfin" ];
}
