{ config, lib, pkgs, spicetify-nix, nur, any-nix-shell, desktop, laptop, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "92a6e5fc1e943f22aad53afbe009103315d8495e";
    hash = "sha256-ld6tQXYVgjfI2FtD/XdsVeujTJEnHRBMFjnL0fMMFqg=";
    fetchSubmodules = true;
  };
in
{

  imports = [
    ./software/alacritty.nix
    ./software/firefox.nix
    ./software/fish.nix
    ./software/spotify.nix
    ./software/neovim.nix
  ];

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "23.05";

    packages = with pkgs; [
      htop
      emacs-gtk
      nextcloud-client
      kate
      pavucontrol
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      ranger
      eza
      bitwarden
      playerctl
      pulseaudio
      libnotify
      gcc
      xfce.thunar
      ranger
      bat
      agda
      cmake
      gnumake
      libtool
      sqlite
      mpv
      jellyfin-media-player
      signal-desktop
      qview
      krdc
      remmina
      kotatogram-desktop
      nixpkgs-fmt
      zathura
      lazygit
      speedtest-rs
      # any-nix-shell
      python3
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science sv ]))
      ripgrep
      texlive.combined.scheme-full
      (lutris.override {
        extraLibraries = pkgs: [
          libnghttp2
          pcre
        ];
        extraPkgs = lutrisPkgs: [
          wine64
          wineWowPackages.waylandFull
          winetricks
          wget
          p7zip
          protontricks
          gnome.zenity
        ];
      })
      slack
      rnote
      catppuccin
      unzip
      steam
      steam-run
      networkmanagerapplet
      fallout-ce
      nurl
      killall
      feishin
      any-nix-shell.outputs.packages.x86_64-linux.any-nix-shell
      fluffychat
      cockatrice
    ] ++
    (lib.optionals desktop [
      openmw
      rofi
      betterlockscreen
      gamemode
      (xivlauncher.overrideAttrs (finalAttrs: previousAttrs: {
        postPatch = previousAttrs.postPatch + ''
          substituteInPlace src/XIVLauncher.Core/Components/SettingsPage/Tabs/SettingsTabWine.cs \
            --replace 'libgamemodeauto.so.0' '${pkgs.gamemode.lib}/lib/libgamemodeauto.so.0'
        '';
      }))
      prismlauncher
      flameshot
      rofi-bluetooth
    ]) ++
    (lib.optionals laptop [
      wofi
      brightnessctl
      acpi
      swaylock-effects
      sway-contrib.grimshot
    ]) ++
    # Own scripts
    (lib.optionals desktop [
      (pkgs.writeScriptBin "mylock" (builtins.readFile ./scripts/desktop/mylock))
      (pkgs.writeScriptBin "change-source.sh" (builtins.readFile ./scripts/desktop/change-source.sh))
      (pkgs.writeScriptBin "nick-source.sh" (builtins.readFile ./scripts/desktop/nick-source.sh))
      (pkgs.writeScriptBin "notify" (builtins.readFile ./scripts/desktop/notify))
      (pkgs.writeScriptBin "rofi_powermenu" (builtins.readFile ./scripts/desktop/rofi_powermenu))
      (pkgs.writeScriptBin "wacom.sh" (builtins.readFile ./scripts/desktop/wacom.sh))
    ]) ++
    (lib.optionals laptop [
      (pkgs.writeScriptBin "notify" (builtins.readFile ./scripts/laptop/notify))
      (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile ./scripts/laptop/wofi_powermenu_w))
      (pkgs.writeScriptBin "mylock" (builtins.readFile ./scripts/laptop/mylock))
    ]);

    file = {
      ".config/river/init".source = ./files/riverconfig;
      ".config/river/init".executable = true;

      ".config/bspwm/bspwmrc".source = ./files/bspwmrc;
      ".config/bspwm/bspwmrc".executable = true;

      ".config/sxhkd/sxhkdrc".source = ./files/sxhkdrc;
      ".config/sxhkd/sxhkdrc".executable = true;

      ".config/rofi/config.rasi".source = ./files/config.rasi;
      ".local/share/rofi/themes".source = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "rofi";
          rev = "5350da41a11814f950c3354f090b90d4674a95ce";
          hash = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
        } + "/basic/.local/share/rofi/themes";

      ".config/dunst/dunstrc".source = ./files/dunstrc;

      ".config/kanshi/config".source = ./files/kanshiconfig;

      ".config/wofi/config".source = ./files/woficonfig;
      ".config/wofi/style.css".source = ./files/wofi.css;
      ".config/wofi/style.css".executable = true;

      ".config/mako/config".source = ./files/makoconfig;

      ".config/doom/".source = pkgs.symlinkJoin {
        name = "doom-config";
        paths = [
          doom-dots

        ];
      };

      ".config/bat/themes/Catppuccin-latte.tmTheme".source = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        } + "/Catppuccin-latte.tmTheme";

      ".config/fish/themes/Catppuccin Latte.theme".source = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "fish";
          rev = "91e6d6721362be05a5c62e235ed8517d90c567c9";
          sha256 = "sha256-l9V7YMfJWhKDL65dNbxaddhaM6GJ0CFZ6z+4R6MJwBA=";
        } + "/themes/Catppuccin Latte.theme";

      ".config/wireplumber/wireplumber.conf.d/50-bluez.conf".source = ./files/bluez;
    };

    pointerCursor = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
      x11 = {
        enable = true;
        defaultCursor = "capitaine-cursors";
      };
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${homeDir}";
    documents = "${homeDir}/doc";
    download = "${homeDir}/dwn";
    music = "${homeDir}/msc";
    pictures = "${homeDir}/pic";
    publicShare = "${homeDir}/srv";
    templates = "${homeDir}/doc/templates";
    videos = "${homeDir}/vid";
  };

  programs = {
    git = {
      enable = true;
      userName = "pingu";
      userEmail = "nor@acorneroftheweb.com";
      difftastic = {
        enable = true;
        background = "light";
      };
      extraConfig = {
        pull.rebase = true;
      };
    };

    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };

    obs-studio = lib.mkIf desktop {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-tuna
        obs-vaapi
        obs-nvfbc
        obs-vkcapture
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Latte-Compact-Pink-Light";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "latte";
      };
    };
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
    };
    iconTheme = {
      name = "Zafiro-icons";
      package = pkgs.zafiro-icons;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
    font = {
      name = "Fira code";
      package = pkgs.fira-code;
      size = 12;
    };
  };

  services.gammastep = {
    enable = true;
    enableVerboseLogging = true;
    longitude = 57.708870;
    latitude = 11.974560;
  };

  services.picom = lib.mkIf desktop {
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

  systemd.user = {
    timers = {
      battery-check = {
        Unit.Description = "Warn at low battery levels";
        Timer = {
          OnBootSec = "1min";
          OnUnitActiveSec = "30s";
          Unit = "battery-check.service";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
    services = lib.mkIf desktop {
      battery-check = {
        Unit.Description = "Warn at low battery levels";
        Service =
          let
            batMon = pkgs.writeShellScript "batMon" ''
              PATH="$PATH:${pkgs.lib.makeBinPath [
                pkgs.acpi
                pkgs.libnotify
                pkgs.gnugrep
                pkgs.gawk
                pkgs.systemd
              ]}"
              acpi -b | grep "Battery 0" | awk -F'[,:%]' '{print $2, $3}' | {
                read -r status capacity
                battery_stat="$(acpi --battery | head -n 1)"
                if [ "$status" = Discharging -a "$capacity" -le 2 ]; then
                  notify-send "Battery Critical: $battery_percentage\n Hibernating"
                  sleep 5
                  systemctl hibernate
                elif [ "$status" = Discharging -a "$capacity" -le 5 ]; then
                  notify-send "Battery Critical: $battery_percentage"
                fi
              }
            '';
          in
          {
            ExecStart = "${batMon}";
          };
      };
    };
  };

  news.display = "silent";
  programs.home-manager.enable = true;

}
