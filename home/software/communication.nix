{ config, lib, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./signal.nix
    ./slack.nix
    ./teams.nix
    ./telegram.nix
    ./thunderbird.nix
  ];
}
