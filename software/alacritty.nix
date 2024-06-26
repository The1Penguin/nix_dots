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
          family = "Doki Doki Mono";
          style = "Regular";
        };
        bold = {
          family = "Doki Doki Mono";
          style = "Bold";
        };
        italic = {
          family = "Doki Doki Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Doki Doki Mono";
          style = "Bold Italic";
        };
        size = 16.0;
      };

      shell = {
        program = "fish";
      };

      colors = {
        primary = {
          background = "#EFF1F5";
          foreground = "#4C4F69";
          dim_foreground = "#4C4F69";
          bright_foreground = "#4C4F69";
        };
        cursor = {
          text = "#EFF1F5";
          cursor = "#DC8A78";
        };
        vi_mode_cursor = {
          text = "#EFF1F5";
          cursor = "#7287FD";
        };
        search = {
          matches = {
            foreground = "#EFF1F5";
            background = "#6C6F85";
          };
          focused_match = {
            foreground = "#EFF1F5";
            background = "#40A02B";
          };
        };

        footer_bar = {
          foreground = "#EFF1F5";
          background = "#6C6F85";
        };

        hints = {
          start = {
            foreground = "#EFF1F5";
            background = "#DF8E1D";
          };
          end = {
            foreground = "#EFF1F5";
            background = "#6C6F85";
          };
        };

        selection = {
          text = "#EFF1F5";
          background = "#DC8A78";
        };

        normal = {
          black = "#5C5F77";
          red = "#D20F39";
          green = "#40A02B";
          yellow = "#DF8E1D";
          blue = "#1E66F5";
          magenta = "#EA76CB";
          cyan = "#179299";
          white = "#ACB0BE";
        };

        bright = {
          black = "#6C6F85";
          red = "#D20F39";
          green = "#40A02B";
          yellow = "#DF8E1D";
          blue = "#1E66F5";
          magenta = "#EA76CB";
          cyan = "#179299";
          white = "#BCC0CC";
        };

        dim = {
          black = "#5C5F77";
          red = "#D20F39";
          green = "#40A02B";
          yellow = "#DF8E1D";
          blue = "#1E66F5";
          magenta = "#EA76CB";
          cyan = "#179299";
          white = "#ACB0BE";
        };

        indexed_colors = [
          { index = 16; color = "#FE640B"; }
          { index = 17; color = "#DC8A78"; }
        ];
      };
    };
  };
}
