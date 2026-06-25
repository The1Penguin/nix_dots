{ config, lib, pkgs, ... }:

{

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 30;
    x11 = {
      enable = true;
      defaultCursor = "capitaine-cursors";
    };
  };
}
