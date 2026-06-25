{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    openjdk
    ghc
    python3
    gcc
    nixpkgs-fmt
  ];
}

