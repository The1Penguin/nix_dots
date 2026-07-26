{ config, lib, pkgs, ... }:

{

  home.pointerCursor = {
    enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 30;
    x11 = {
      enable = true;
      defaultCursor = "capitaine-cursors";
    };
  };
}
