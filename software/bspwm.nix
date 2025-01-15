{ config, lib, pkgs, desktop, laptop, ... }:

{

  home.packages = with pkgs; [
    feh
    rofi
    betterlockscreen
    flameshot
    rofi-bluetooth
    (pkgs.writeScriptBin "mylock" (builtins.readFile ../scripts/x/mylock))
    (pkgs.writeScriptBin "rofi_powermenu" (builtins.readFile ../scripts/x/rofi_powermenu))
    (pkgs.writeScriptBin "wacom.sh" (builtins.readFile ../scripts/x/wacom.sh))
  ] ++ (lib.optionals desktop [
    (pkgs.writeScriptBin "change-source.sh" (builtins.readFile ../scripts/desktop/change-source.sh))
    (pkgs.writeScriptBin "nick-source.sh" (builtins.readFile ../scripts/desktop/nick-source.sh))
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/desktop/notify))
  ]) ++ (lib.optionals laptop [
  ]);

  xsession.windowManager.bspwm = {
    enable = true;
    alwaysResetDesktops = true;
    monitors = {
      DP-4 = map toString (lib.lists.range 1 5);
      DP-0 = map toString (lib.lists.range 6 10);
    };
    settings = {
      click_to_focus = "button1";
      border_width = 3;
      window_gap = 6;
      swallow_first_click = false;
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;
      ignore_ewmh_focus = false;
      normal_border_color = "#9ca0b0";
      active_border_color = "#9ca0b0";
      focused_border_color = "#ea76cb";
      presel_feedback_color = "#acb0be";
    };
    extraConfig = ''
      xsetroot -cursor_name left_ptr &
      feh --bg-fill ~/pic/Wallpaper/sakuraflower.png
      xset -dpms s off
    '';
    rules = {
      "Emacs".state = "tiled";
      "mpv".state = "pseudo_tiled";
      "Zathura".state = "tiled";
    };
  };

  services = {
    picom = {
      enable = true;
      backend = "glx";
      settings = {
        corner.radius = 8;
        round.borders = 1;
        blur = {
          background = true;
          kern = "3x3box";
          method = "dual_kawase";
          strength = 3.4;
        };
        refresh.rate = 144;
      };
    };

    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty";
        "super + d" = "rofi -show drun";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "alt + shift + x" = "betterlockscreen -l dimblur";
        "super + {F9, F10, F11}" = "playerctl {previous,play-pause,next}";
        "{XF86AudioPause,XF86AudioNext,XF86AudioPrev}" = "playerctl {play-pause,next,previous}";
        "super + F1" = "firefox";
        "super + F2" = "vesktop --no-sandbox";
        "super + F3" = "exec spotify";
        "super + F4" = "lutris";
        "super + F5" = "XIVLauncher.Core";
        "super + p" = "pavucontrol";
        "super + u" = "exec bitwarden";
        "super + e" = "emacs";
        "super + v" = "emacsclient --eval \"(emacs-everywhere)\"";
        "super + i" = "exec wacom.sh";
        "super + o" = "exec change-source.sh";
        "Print" = "flameshot gui";
        "super + shift + Tab" = "exec rofi_powermenu";
        "super + a" = "exec rofi-bluetooth";
        "super + Tab" = "exec notify";
        "super + space" = "xdotool key F19";
        "super + alt + r" = "bspc wm -r";
        "super + {_,shift + }q" = "bspc node -{c,k}";
        "super + m" = "bspc desktop -l next";
        "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";
        "super + {_,shift + }{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";
        "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
        "super + {_,shift + }c" = "bspc node -f {next,prev}.local";
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "super + r" = "bspc node @/ -C forward";
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
        "super + ctrl + space" = "bspc node -p cancel";
        "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
        "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + alt + {Left,Down,Up,Right}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {Left,Down,Up,Right}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + ctrl + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
    };

    dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 0;
          follow = "none";
          width = 350;
          height = 300;
          origin = "top-right";
          offset = "7x7";
          scale = 0;
          notification_limit = 0;

          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;

          transparency = 30;
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          text_icon_padding = 0;
          frame_width = 2;
          frame_color = "#EA76CB";
          separator_color = "frame";
          corner_radius = 3;

          font = "DokiDokiMono Nerd Font 14";
          line_height = 0;
          markup = "full";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          ellipsize = "middle";
          ignore_newline = "no";

          format = "<b>%s</b>\n%b";

          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = "yes";

          sticky_history = "yes";
          history_length = 20;

          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";

          always_run_script = true;
          ignore_dbusclose = false;
          force_xwayland = false;
          force_xinerama = false;
          indicate_hidden = "yes";
          sort = "yes";
        };

        urgency_low = {
          background = "#eff1f5";
          foreground = "#4c4f69";
          timeout = 6;
        };
        urgency_normal = {
          background = "#eff1f5";
          foreground = "#4c4f69";
          timeout = 6;
        };
        urgency_critical = {
          background = "#eff1f5";
          foreground = "#4c4f69";
          frame_color = "#d20f39";
          timeout = 0;
        };
      };
    };
  };

  catppuccin.dunst.enable = false;

}
