{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    feh
    dunst
    rofi
    betterlockscreen
    flameshot
    rofi-bluetooth
    (pkgs.writeScriptBin "mylock" (builtins.readFile ../scripts/desktop/mylock))
    (pkgs.writeScriptBin "change-source.sh" (builtins.readFile ../scripts/desktop/change-source.sh))
    (pkgs.writeScriptBin "nick-source.sh" (builtins.readFile ../scripts/desktop/nick-source.sh))
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/desktop/notify))
    (pkgs.writeScriptBin "rofi_powermenu" (builtins.readFile ../scripts/desktop/rofi_powermenu))
    (pkgs.writeScriptBin "wacom.sh" (builtins.readFile ../scripts/desktop/wacom.sh))
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    alwaysResetDesktops = true;
    monitors = {
      DP-4 = map toString [ 1 2 3 4 5 ];
      DP-0 = map toString [ 6 7 8 9 10 ];
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
      extraConfig = builtins.readFile ../files/sxhkdrc;
    };

    dunst = {
      enable = true;
      catppuccin.enable = false;
      configFile = ../files/dunstrc;
    };
  };
}
