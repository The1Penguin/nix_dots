{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    swaylock-effects
    wofi
    brightnessctl
    acpi
    sway-contrib.grimshot
    rivercarro
    swaybg
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/laptop/notify))
    (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile ../scripts/laptop/wofi_powermenu_w))
    (pkgs.writeScriptBin "mylock" (builtins.readFile ../scripts/laptop/mylock))
  ];

  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    systemd.variables = [
      "DISPLAY"
      "WAYLAND_DISPLAY"
      "XDG_SESSION_TYPE"
      "XDG_CURRENT_DESKTOP"
      "XDG_SESSION_DESKTOP"
      "NIXOS_OZONE_WL"
      "XCURSOR_THEME"
      "XCURSOR_SIZE"
    ];
    systemd.extraCommands = [
      "systemctl --user stop river-session.target"
      "systemctl --user start river-session.target"
      "rivercarro -inner-gaps 3 -outer-gaps 3 -no-smart-gaps -main-ratio 0.63"
    ];
    settings = {
      default-layout = "rivercarro";
      rule-add = {
        "-app-id" = {
          "'firefox'" = "ssd";
          "'steam'" = "ssd";
        };
      };
      set-repeat = "40 300";
      xcursor-theme = "capitaine-cursors 32";
      border-color = "0xeff1f5";
      border-color-focused = "0xea76cb";
      border-color-unfocused = "0x9ca0b0";
      keyboard-layout = "-options ctrl:nocaps sebrackets";
      input = {
        "pointer-1267-12608-ELAN0001:00_04F3:3140_Touchpad" = {
          events = true;
          tap = true;
          tap-button-map = "left-right-middle";
        };
      };
      declare-mode = [
        "normal"
        "passthrough"
      ];
      map = {
        passthrough."Super F11" = "enter-mode normal";
        normal = lib.attrsets.unionOfDisjoint
          {
            "Super F11" = "enter-mode passthrough";
            "Super Return" = "spawn alacritty";
            "Super Q" = "close";
            "Super+Shift E" = "exit";
            "Super J" = "focus-view next";
            "Super K" = "focus-view previous";
            "Super+Shift J" = "swap next";
            "Super+Shift K" = "swap previous";
            "Super Period" = "focus-output next";
            "Super Space" = "focus-output next";
            "Super Comma" = "focus-output previous";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Space" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";
            "Super H" = "send-layout-cmd rivercarro 'main-ratio -0.05'";
            "Super L" = "send-layout-cmd rivercarro 'main-ratio +0.05'";
            "Super+Shift H" = "send-layout-cmd rivercarro 'main-count +1'";
            "Super+Shift L" = "send-layout-cmd rivercarro 'main-count -1'";
            "Super+Alt H" = "move left 100";
            "Super+Alt J" = "move down 100";
            "Super+Alt K" = "move up 100";
            "Super+Alt L" = "move right 100";
            "Super+Alt+Control H" = "snap left";
            "Super+Alt+Control J" = "snap down";
            "Super+Alt+Control K" = "snap up";
            "Super+Alt+Control L" = "snap right";
            "Super+Alt+Shift H" = "resize horizontal -100";
            "Super+Alt+Shift J" = "resize vertical 100";
            "Super+Alt+Shift K" = "resize vertical -100";
            "Super+Alt+Shift L" = "resize horizontal 100";
            "Super 0" = "set-focused-tags 2147483647";
            "Super+Shift 0" = "set-view-tags 2147483647";
            "Super T" = "toggle-float";
            "Super F" = "toggle-fullscreen";
            "Super Up" = "send-layout-cmd rivercarro 'main-location top'";
            "Super Right" = "send-layout-cmd rivercarro 'main-location right'";
            "Super Down" = "send-layout-cmd rivercarro 'main-location bottom'";
            "Super Left" = "send-layout-cmd rivercarro 'main-location left'";
            "Super M" = "send-layout-cmd rivercarro 'main-location monocle'";
            "None XF86Eject" = "spawn 'eject -T'";
            "None XF86AudioRaiseVolume" = "spawn 'pactl set-sink-volume @DEFAULT_SINK@ +5%'";
            "None XF86AudioLowerVolume" = "spawn 'pactl set-sink-volume @DEFAULT_SINK@ -5%'";
            "None XF86AudioMute" = "spawn 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
            "None XF86AudioMedia" = "spawn 'playerctl play-pause'";
            "None XF86AudioPlay" = "spawn 'playerctl play-pause'";
            "None XF86AudioPrev" = "spawn 'playerctl previous'";
            "None XF86AudioNext" = "spawn 'playerctl next'";
            "None XF86MonBrightnessUp" = "spawn 'brightnessctl s 5+'";
            "None XF86MonBrightnessDown" = "spawn 'brightnessctl s 5-'";
            "Super D" = "spawn 'wofi --show=drun --hide-scroll'";
            "Super E" = "spawn 'emacs'";
            "Super F1" = "spawn 'firefox'";
            "Super F2" = "spawn 'discord'";
            "Super F3" = "spawn 'spotify'";
            "Alt+Shift X" = "spawn 'mylock'";
            "Super+Shift Tab" = "spawn 'wofi_powermenu_w'";
            "Super Tab" = "spawn 'notify'";
            "None Print" = "spawn 'grimshot copy area'";
            "Super P" = "spawn 'pavucontrol'";
            "Super U" = "spawn 'bitwarden'";
            "Super BTN_LEFT" = "move-view";
            "Super BTN_RIGHT" = "resize-view";
          }
          (builtins.listToAttrs (
            lib.concatMap
              (x:
                [{
                  name = "Super " + toString x;
                  value = "set-focused-tags " + toString (lib.foldr (a: b: a * b) 1 (lib.replicate (x - 1) 2));
                }] ++
                [{
                  name = "Super+Shift " + toString x;
                  value = "set-view-tags " + toString (lib.foldr (a: b: a * b) 1 (lib.replicate (x - 1) 2));
                }] ++
                [{
                  name = "Super+Control " + toString x;
                  value = "toggle-focused-tags " + toString (lib.foldr (a: b: a * b) 1 (lib.replicate (x - 1) 2));
                }] ++
                [{
                  name = "Super+Shift+Control " + toString x;
                  value = "toggle-view-tags " + toString (lib.foldr (a: b: a * b) 1 (lib.replicate (x - 1) 2));
                }]
              )
              (lib.range 1 9)));
      };
    };
    extraConfig = "exec swaybg -i ~/pic/Wallpaper/sakuraflower.png -m fill &";
  };

  services = {
    mako = {
      enable = true;
      catppuccin.enable = false;
      # extraConfig = builtins.readFile ../files/makoconfig;
      anchor = "top-right";
      backgroundColor = "#eff1f5";
      borderColor = "#ea76cb";
      borderRadius = 15;
      borderSize = 2;
      defaultTimeout = 10000;
      font = "DokiDokiMono Nerd Font 14";
      format = "<i>%s</i>\\n%b";
      groupBy = "summary";
      height = 200;
      layer = "overlay";
      margin = "20,20,0";
      markup = true;
      maxIconSize = 96;
      padding = "15,15,15";
      progressColor = "over #c6cad1";
      textColor = "#4c4f69";
      width = 450;
    };

    kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
            }
          ];
        }
        {
          profile.name = "TV";
          profile.outputs = [
            {
              criteria = "eDP-1";
              position = "0,0";
            }
            {
              criteria = "Samsung Electric Company SAMSUNG 0x00000700";
              position = "1920,0";
              mode = "3840x2160@60Hz";
              scale = 2.0;
            }
          ];
        }
        {
          profile.name = "Monitor_Kumla";
          profile.outputs = [
            {
              criteria = "eDP-1";
              position = "320,1440";
            }
            {
              criteria = "AOC Q32V4WG5 QHPM4HA001642";
              position = "0,0";
              mode = "2560x1440@59.951Hz";
            }
          ];
        }
      ];
    };
  };

  systemd.user.services.kanshi-river = {
    Unit = {
      Description = "Kanshi but on river";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      Restart = "always";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
