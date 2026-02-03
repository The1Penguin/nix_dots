{ config, lib, pkgs, ... }:
let
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "bf005e5d88adbdb789cd2526ebb7a30923ef1e68";
    hash = "sha256-Put4L7piL5zXPORLxE8FelJN4cZXUHWMjJy5YNVsyfM=";
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
