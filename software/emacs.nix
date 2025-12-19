{ config, lib, pkgs, ... }:
let
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "fa427b634d2c3368e45289fbda39707d44666cd1";
    hash = "sha256-PAMFIH8MMA70TncpjHn+onsqt1cKFy6rdk8JCMejG2Q=";
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
