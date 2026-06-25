{ config, lib, pkgs, ... }:

{
  home.packages = [
    (pkgs.stable.openmw.overrideAttrs (o: {
      version = "0.51.0";
      src = pkgs.fetchFromGitLab {
        owner = "OpenMW";
        repo = "openmw";
        tag = "openmw-0.51.0";
        hash = "sha256-D+2nEQRkAjmDvRoas9bYPmdygQYT3MAv46n73OonE0o=";
      };
    }))
  ];
}
