{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty-graphics;
    settings = {
      window = {
        padding = {
          x = 5;
          y = 3;
        };
        dynamic_padding = true;
        blur = true;
        title = "Alacritty";
        dynamic_title = false;
        opacity = 0.93;
      };

      scrolling = {
        multiplier = 1;
      };

      font = {
        normal = {
          family = "Monaspace Neon NF";
          style = "Regular";
        };
        bold = {
          family = "Monaspace Neon NF";
          style = "Bold";
        };
        italic = {
          family = "Monaspace Neon NF";
          style = "Italic";
        };
        bold_italic = {
          family = "Monaspace Neon NF";
          style = "Bold Italic";
        };
        size = 14.0;
      };

      terminal.shell.program = "fish";
    };
  };
}
