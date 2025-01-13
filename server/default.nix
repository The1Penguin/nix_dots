{ config, lib, pkgs, ... }:

{
  imports = [
    ./services/audiobookshelf.nix
  ];
}
