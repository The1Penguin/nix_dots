{ config, lib, pkgs, ... }:
let
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "f7d4e939d29328bfda1a4b13ef35e095c6d5e03d";
    hash = "sha256-YfBQbPJm+ZbRSyKccUvpkb9DEhjEQo7QEJqc2hh2yFI=";
    fetchSubmodules = true;
  };
in
{
  home = {
    packages = with pkgs; [
      emacs-pgtk
      (agda.withPackages (p: with p; [
        standard-library
      ]))
      cmake
      gnumake
      libtool
      sqlite
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science sv ]))
    ];

    file = {
      ".config/doom/".source = pkgs.symlinkJoin {
        name = "doom-config";
        paths = [
          doom-dots
        ];
      };
    };
  };
}
