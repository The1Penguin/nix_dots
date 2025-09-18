{ config, lib, pkgs, ... }:

{

  programs = {
    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
        pride_month_disable = false;
      };
    };

    fastfetch = {
      enable = true;
      settings = {
        modules = [
          "title"
          "separator"
          "os"
          "kernel"
          "uptime"
          "packages"
          "shell"
          { type = "wm"; format = "{2}"; }
          "cursor"
          { type = "cpu"; format = "{1}"; }
          { type = "gpu"; format = "{1} {2}"; }
          { type = "terminal"; format = "{5}"; }
          "terminalfont"
          "break"
          "colors"
        ];
      };
    };
  };
}
