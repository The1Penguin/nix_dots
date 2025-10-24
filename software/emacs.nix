{ config, lib, pkgs, ... }:
let
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "2068b75fa5129ed25e30806e6c4cc3396969c44e";
    hash = "sha256-7a+dvYlPBCbmouUPZ3RWl6cBqf0LTBBUPXZQp2UJjrg=";
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
