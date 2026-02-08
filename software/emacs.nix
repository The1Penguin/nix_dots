{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      emacs-pgtk
      (agda.withPackages (p: with p; [
        standard-library
        cubical
      ]))
      cmake
      gnumake
      libtool
      sqlite
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science sv ]))
    ];

    file = {
      ".config/doom/config.el".source   = ./doom/config.el;
      ".config/doom/init.el".source     = ./doom/init.el;
      ".config/doom/packages.el".source = ./doom/packages.el;
      ".config/doom/splash.svg".source  = ./doom/splash.svg;
    };
  };
}
