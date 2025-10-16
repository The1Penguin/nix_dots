{ config, lib, pkgs, ... }:
let
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "e694225acc48e9711fd5ce75e58dc845be227ad7";
    hash = "sha256-RcurBuYPVfWK3McBbxXDr6ulyAZLWe0dBS5Yhi25eog=";
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
