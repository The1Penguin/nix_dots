args@{ config, lib, pkgs, desktop, laptop, ... }:

{

  imports = [
    ./kanshi.nix
    ./mako.nix
    (import ./swaybg.nix (args // { wallpaper = ../sakuraflower.png; }))
  ];

  home.packages = with pkgs; [
    swaylock-effects
    wofi
    brightnessctl
    acpi
    sway-contrib.grimshot
    rivercarro
    swaybg
    (pkgs.writeScriptBin "mylock" (builtins.readFile ../scripts/wayland/mylock))
    (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile ../scripts/wayland/wofi_powermenu_w))
  ] ++
  (lib.optionals desktop [
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/desktop/notify))
  ]) ++ (lib.optionals laptop [
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/laptop/notify))
  ]);

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
      "rivercarro -inner-gaps 3 -outer-gaps 3 -no-smart-gaps -per-tag -main-ratio 0.63"
    ];
    settings = {
      default-layout = "rivercarro";
      rule-add = {
        "-app-id" = {
          "'firefox'" = "ssd";
          "'librewolf'" = "ssd";
          "'steam'" = "ssd";
          "'org.pulseaudio.pavucontrol'" = "ssd";
          "'emacs'" = "ssd";
        };
      };
      set-repeat = "40 300";
      xcursor-theme = "capitaine-cursors 30";
      border-color = "0xeff1f5";
      border-color-focused = "0xea76cb";
      border-color-unfocused = "0x9ca0b0";
      keyboard-layout = "sebrackets";
      input = {
        "pointer-1739-52992-SYNA2BA6:00_06CB:CF00_Touchpad" = {
          events = true;
          tap = true;
          tap-button-map = "left-right-middle";
        };
        "pointer-1133-16511-Logitech_G502" = {
          accel-profile = "none";
        };
      };
      declare-mode = [
        "normal"
        "passthrough"
      ];
      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
        };
      };
      map = {
        passthrough."Super F11" = "enter-mode normal";
        normal = lib.attrsets.unionOfDisjoint
          {
            "Super F11" = "enter-mode passthrough";
            "Super Return" = "spawn ${pkgs.alacritty-graphics}/bin/alacritty";
            "Super Q" = "close";
            "Super+Shift E" = "exit";
            "Super J" = "focus-view next";
            "Super K" = "focus-view previous";
            "Super+Shift J" = "swap next";
            "Super+Shift K" = "swap previous";
            "Super Period" = "focus-output next";
            "Super Space" = "focus-output next";
            "Super Comma" = "focus-output previous";
            "Super+Control Space" = "focus-output previous";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Space" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";
            "Super+Control+Shift Space" = "send-to-output previous";
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
            "None XF86AudioRaiseVolume" = "spawn '${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%'";
            "None XF86AudioLowerVolume" = "spawn '${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%'";
            "None XF86AudioMute" = "spawn '${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle'";
            "None XF86AudioMedia" = "spawn '${pkgs.playerctl}/bin/playerctl play-pause'";
            "None XF86AudioPlay" = "spawn '${pkgs.playerctl}/bin/playerctl play-pause'";
            "None XF86AudioPrev" = "spawn '${pkgs.playerctl}/bin/playerctl previous'";
            "None XF86AudioNext" = "spawn '${pkgs.playerctl}/bin/playerctl next'";
            "None XF86MonBrightnessUp" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl s 5%+'";
            "None XF86MonBrightnessDown" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl s 5%-'";
            "Super D" = "spawn '${pkgs.wofi}/bin/wofi --show=drun --hide-scroll'";
            "Super E" = "spawn '${pkgs.emacs-pgtk}/bin/emacs'";
            "Super F1" = "spawn '${pkgs.librewolf}/bin/librewolf'";
            "Super F2" = "spawn '${pkgs.stable.vesktop}/bin/vesktop'";
            "Super F3" = "spawn '${pkgs.feishin}/bin/feishin'";
            "Super F4" = "spawn '${pkgs.lutris}/bin/lutris'";
            "Super F5" = "spawn 'XIVLauncher.Core'";
            "Alt+Shift X" = "spawn 'mylock'";
            "Super+Shift Tab" = "spawn 'wofi_powermenu_w'";
            "Super Tab" = "spawn 'notify'";
            "None Print" = "spawn '${pkgs.sway-contrib.grimshot}/bin/grimshot copy area'";
            "Super P" = "spawn '${pkgs.pavucontrol}/bin/pavucontrol'";
            "Super U" = "spawn '${pkgs.bitwarden}/bin/bitwarden'";
          }
          (builtins.listToAttrs (
            lib.concatMap
              (x:
                [{
                  name = "Super " + x.name;
                  value = "set-focused-tags " + x.power;
                }] ++
                [{
                  name = "Super+Shift " + x.name;
                  value = "set-view-tags " + x.power;
                }] ++
                [{
                  name = "Super+Control " + x.name;
                  value = "toggle-focused-tags " + x.power;
                }] ++
                [{
                  name = "Super+Shift+Control " + x.name;
                  value = "toggle-view-tags " + x.power;
                }]
              )
              (map
                (x: {
                  name = toString x;
                  power = toString (lib.foldr (a: b: a * b) 1 (lib.replicate (x - 1) 2));
                })
                (lib.range 1 9))));
        locked = {
          "None XF86AudioRaiseVolume" = "spawn '${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%'";
          "None XF86AudioLowerVolume" = "spawn '${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%'";
          "None XF86AudioMute" = "spawn '${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle'";
          "None XF86AudioMedia" = "spawn '${pkgs.playerctl}/bin/playerctl play-pause'";
          "None XF86AudioPlay" = "spawn '${pkgs.playerctl}/bin/playerctl play-pause'";
          "None XF86AudioPrev" = "spawn '${pkgs.playerctl}/bin/playerctl previous'";
          "None XF86AudioNext" = "spawn '${pkgs.playerctl}/bin/playerctl next'";
          "None XF86MonBrightnessUp" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl s 5%+'";
          "None XF86MonBrightnessDown" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl s 5%-'";
        };
      };
    };
  };

  services.polkit-gnome.enable = true;
}
