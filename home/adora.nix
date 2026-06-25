args@{ config, lib, pkgs, ... }:

let
  username = "pingu";
  homeDir = "/home/${username}";
in
{

  imports = [
    software/bat.nix
    software/catppuccin.nix
    software/emacs.nix
    software/git.nix
    (import software/home.nix (args // { username = username; homeDir = homeDir; }))
    software/home-manager.nix
    software/hyfetch.nix
    software/languages.nix
    software/latex.nix
    software/neovim.nix
    software/nix.nix
    (import software/syncthing.nix (args // { homeDir = homeDir; }))
    software/tailscale.nix
    software/yazi.nix
    software/zellij.nix
  ];
}
