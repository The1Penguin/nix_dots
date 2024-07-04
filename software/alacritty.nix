{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 5;
          y = 3;
        };
        title = "Alacritty";
        dynamic_title = false;
        opacity = 0.93;
      };

      scrolling = {
        multiplier = 1;
      };

      font = {
        normal = {
          family = "DokiDokiMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "DokiDokiMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "DokiDokiMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "DokiDokiMono Nerd Font";
          style = "Bold Italic";
        };
        size = 16.0;
      };

      shell = {
        program = "fish";
      };
    };
  };
}
