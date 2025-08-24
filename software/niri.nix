args@{ config, lib, pkgs, desktop, laptop, ... }:
let
  XWAYLAND_DISPLAY = ":3";
in
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
    swaybg
    (pkgs.writeScriptBin "mylock" (builtins.readFile ../scripts/wayland/mylock))
    (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile ../scripts/wayland/wofi_powermenu_w))
  ] ++
  (lib.optionals desktop [
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/desktop/notify))
  ]) ++ (lib.optionals laptop [
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/laptop/notify))
  ]);

  programs.niri.settings = {
    # Input
    input = {
      keyboard = {
        xkb.layout = "sebrackets";
        repeat-rate = 50;
        repeat-delay = 300;
      };
      touchpad = {
        tap = true;
        click-method = "clickfinger"; #TODO: button areas as well
        natural-scroll = false;
        dwt = true;
      };
      warp-mouse-to-focus.enable = false;
      focus-follows-mouse.enable = false;
    };

    #hotkey-overlay.hide-not-bound = true;
    binds = with config.lib.niri.actions; {
      # Common programs
      "Mod+Return" = {
        hotkey-overlay.title = "Run alacritty";
        action = spawn "${pkgs.alacritty-graphics}/bin/alacritty";
      };
      "Mod+F1" = {
        hotkey-overlay.title = "Run librewolf";
        action = spawn "${pkgs.librewolf}/bin/librewolf";
      };
      "Mod+F2" = {
        hotkey-overlay.title = "Run vesktop";
        action = spawn "${pkgs.stable.vesktop}/bin/vesktop";
      };
      "Mod+F3" = {
        hotkey-overlay.title = "Run feishin";
        action = spawn "${pkgs.feishin}/bin/feishin";
      };
      "Mod+F4" = {
        hotkey-overlay.title = "Run lutris";
        action = spawn "${pkgs.lutris}/bin/lutris";
      };
      "Mod+F5" = {
        hotkey-overlay.title = "Run ffxiv";
        action = spawn "XIVLauncher.Core";
      };
      "Mod+U" = {
        hotkey-overlay.title = "Run bitwarden";
        action = spawn "${pkgs.bitwarden}/bin/bitwarden";
      };
      "Mod+E" = {
        hotkey-overlay.title = "Run emacs";
        action = spawn "${pkgs.emacs-pgtk}/bin/emacs";
      };
      "Mod+P" = {
        hotkey-overlay.title = "Run pavucontrol";
        action = spawn "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      # Launchers
      "Mod+D" = {
        hotkey-overlay.title = "wofi launcher";
        action = spawn "${pkgs.wofi}/bin/wofi" "--show=drun" "--hide-scroll";
      };

      # Utility and help
      "Mod+Comma" = {
        hotkey-overlay.title = "Show hotkeys";
        action = show-hotkey-overlay;
      };

      "Mod+Tab" = {
        hotkey-overlay.title = "notify script";
        action = spawn "notify";
      };

      "Alt+Shift+X" = {
        hotkey-overlay.title = "Lock";
        action = spawn "sh" "-c" "niri msg action do-screen-transition && mylock";
      };

      "Mod+Shift+Tab" = {
        hotkey-overlay.title = "notify script";
        action = spawn "wofi_powermenu_w";
      };

      "Mod+Q" = {
        hotkey-overlay.title = "Close window";
        action = close-window;
      };

      # Screenshots, screenshot-screen is bronken so doing this until it's fixed
      "Print" = {
        hotkey-overlay.title = "Screenshot region";
        action = screenshot;
      };

      #Touchpad
      "Mod+TouchpadScrollRight" = {
        hotkey-overlay.hidden = true;
        action = focus-column-right;
      };
      "Mod+TouchpadScrollLeft" = {
        hotkey-overlay.hidden = true;
        action = focus-column-left;
      };
      "Mod+TouchpadScrollUp" = {
        hotkey-overlay.hidden = true;
        action = focus-window-or-workspace-up;
      };
      "Mod+TouchpadScrollDown" = {
        hotkey-overlay.hidden = true;
        action = focus-window-or-workspace-down;
      };

      # Window and column size
      "Mod+R" = {
        hotkey-overlay.title = "Switch height";
        action = switch-preset-window-height;
      };
      "Mod+F" = {
        hotkey-overlay.title = "Switch width";
        action = switch-preset-column-width;
      };
      "Mod+Shift+F" = {
        hotkey-overlay.title = "Fullscreen";
        action = fullscreen-window;
      };
      "Mod+N" = {
        hotkey-overlay.title = "Reset height";
        action = reset-window-height;
      };
      "Mod+M" = {
        hotkey-overlay.title = "Maximize Column";
        action = maximize-column;
      };

      #Tabs
      "Mod+T" = {
        hotkey-overlay.title = "Switch to tabbed view";
        action = toggle-column-tabbed-display;
      };
      "Mod+Down" = {
        hotkey-overlay.hidden = true;
        action = focus-window-down;
      };
      "Mod+Up" = {
        hotkey-overlay.hidden = true;
        action = focus-window-up;
      };

      # Window and column movement
      "Mod+H" = {
        hotkey-overlay.title = "Focus column/window {hjkl}";
        action = focus-column-left;
      };
      "Mod+L" = {
        hotkey-overlay.hidden = true;
        action = focus-column-right;
      };
      "Mod+Shift+H" = {
        hotkey-overlay.title = "Move column/window {hjkl}";
        action = move-column-left;
      };
      "Mod+Shift+L" = {
        hotkey-overlay.hidden = true;
        action = move-column-right;
      };
      "Mod+V" = {
        hotkey-overlay.title = "Toggle floating windows";
        action = toggle-window-floating;
      };
      "Mod+Shift+V" = {
        hotkey-overlay.title = "Switch tiling/window focus";
        action = switch-focus-between-floating-and-tiling;
      };
      "Mod+Ctrl+H" = {
        hotkey-overlay.title = "Consume or expel {hl}";
        action = consume-or-expel-window-left;
      };
      "Mod+Ctrl+L" = {
        hotkey-overlay.hidden = true;
        action = consume-or-expel-window-right;
      };

      # Workspaces
      "Mod+J" = {
        hotkey-overlay.hidden = true;
        action = focus-window-or-workspace-down;
      };
      "Mod+K" = {
        hotkey-overlay.hidden = true;
        action = focus-window-or-workspace-up;
      };
      "Mod+Shift+J" = {
        hotkey-overlay.title = "Move window or workspace {jk}";
        action = move-window-down-or-to-workspace-down;
      };
      "Mod+Shift+K" = {
        # hotkey-overlay.title = "Move window or workspace up";
        hotkey-overlay.hidden = true;
        action = move-window-up-or-to-workspace-up;
      };
      "Mod+O" = {
        hotkey-overlay.title = "Toggle overview";
        action = toggle-overview;
      };
      "Mod+1" = {
        action = focus-workspace 1;
      };
      "Mod+2" = {
        action = focus-workspace 2;
      };
      "Mod+3" = {
        action = focus-workspace 3;
      };
      "Mod+4" = {
        action = focus-workspace 4;
      };
      "Mod+5" = {
        action = focus-workspace 5;
      };
      "Mod+6" = {
        action = focus-workspace 6;
      };
      "Mod+7" = {
        action = focus-workspace 7;
      };
      "Mod+8" = {
        action = focus-workspace 8;
      };
      "Mod+9" = {
        action = focus-workspace 9;
      };

      # Monitor movement
      "Mod+Space" = {
        hotkey-overlay.title = "Focus next monitor"; # Assuming two monitors
        action = focus-monitor-next;
      };
      "Mod+Shift+Space" = {
        hotkey-overlay.title = "Move window to next monitor"; # Assuming two monitors
        action = move-window-to-monitor-next;
      };

      # Dynamic screen cast
      # "Mod+M" = {
      #   hotkey-overlay.title = "Dynamic cast window";
      #   action = set-dynamic-cast-window;
      # };
      # "Mod+Shift+M" = {
      #   hotkey-overlay.title = "Dynamic cast monitor";
      #   action = set-dynamic-cast-monitor;
      # };
      # "Mod+Shift+C" = {
      #  hotkey-overlay.title = "Clear dynamic cast target";
      #   action = clear-dynamic-cast-target;
      # };

      # Function row
      "XF86MonBrightnessDown" = {
        action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "s" "5%-" ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessUp" = {
        action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "s" "5%+" ];
        allow-when-locked = true;
      };

      "XF86LaunchA".action = toggle-overview;

      "XF86Sleep".action = spawn "sh" "-c" "niri msg action do-screen-transition && mylock";

      "XF86AudioPrev" = {
        action = spawn "${pkgs.playerctl}/bin/playerctl" "previous";
        allow-when-locked = true;
      };
      "XF86AudioPlay" = {
        action = spawn "${pkgs.playerctl}/bin/playerctl" "play-pause";
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action = spawn "${pkgs.playerctl}/bin/playerctl" "next";
        allow-when-locked = true;
      };

      "XF86AudioMute" = {
        action = spawn "${pkgs.pulseaudio}/bin/pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = spawn "${pkgs.pulseaudio}/bin/pactl" "set-sink-volume" "@DEFAULT_SINK@" "5%-";
        allow-when-locked = true;
      };
      "XF86AudioRaiseVolume" = {
        action = spawn "${pkgs.pulseaudio}/bin/pactl" "set-sink-volume" "@DEFAULT_SINK@" "5%+";
        allow-when-locked = true;
      };
    };

    gestures = {
      hot-corners.enable = false;
    };

    switch-events = with config.lib.niri.actions; {
      "lid-close" = {
        action = spawn "sh" "-c" "niri msg action do-screen-transition && mylock";
      };
    };

    spawn-at-startup = [
      { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" XWAYLAND_DISPLAY ]; }
      { command = [ "${pkgs.dbus}/bin/dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" ]; } # needed for screen-sharing to work
    ];
    environment.DISPLAY = XWAYLAND_DISPLAY;

    prefer-no-csd = true;

    layer-rules = [
      {
        matches = [{ namespace = "^notifications$"; }];
        block-out-from = "screencast";
      }
    ];

    window-rules = [
      {
        open-maximized = true;
      }
    ];

    overview = {
      workspace-shadow.enable = false;
      zoom = 0.4;
    };

    cursor.size = 30;

    layout = {
      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
        { proportion = 1. / 1.; }
      ];
      preset-window-heights = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
        { proportion = 1. / 1.; }
      ];
      border = {
        enable = true;
        width = 3;
        active.color = "#ea76cb";
        inactive.color = "#9ca0b0";
      };
      gaps = 4;
      focus-ring.enable = false;
    };
  };
}
