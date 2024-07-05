{ config, lib, pkgs, spicetify-nix, nur, any-nix-shell, desktop, laptop, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "7703a4763479500bb0d8b5a3da4de460b5979e32";
    hash = "sha256-5tBnpp9SJ26j5gpWxJEXPIXuRgrY1q+I5YNAl19EEog=";
    fetchSubmodules = true;
  };
  dokidokimono = import ./software/dokidokimono.nix { inherit pkgs; };
in
{

  imports = [
    ./software/alacritty.nix
    ./software/firefox.nix
    ./software/fish.nix
    ./software/spotify.nix
    ./software/neovim.nix
  ] ++ (lib.optionals laptop [
    ./software/river.nix
  ]);

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
      agda
      cmake
      gnumake
      libtool
      sqlite
      jellyfin-media-player
      signal-desktop
      qview
      krdc
      remmina
      kotatogram-desktop
      nixpkgs-fmt
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
      (pkgs.writeScriptBin "ffxiv-backup" (builtins.readFile ./scripts/desktop/ffxiv-backup))
      (pkgs.writeScriptBin "ffxiv-update" (builtins.readFile ./scripts/desktop/ffxiv-update))
      prismlauncher
      flameshot
      rofi-bluetooth
    ]) ++
    # Own scripts
    (lib.optionals desktop [
      (pkgs.writeScriptBin "mylock" (builtins.readFile ./scripts/desktop/mylock))
      (pkgs.writeScriptBin "change-source.sh" (builtins.readFile ./scripts/desktop/change-source.sh))
      (pkgs.writeScriptBin "nick-source.sh" (builtins.readFile ./scripts/desktop/nick-source.sh))
      (pkgs.writeScriptBin "notify" (builtins.readFile ./scripts/desktop/notify))
      (pkgs.writeScriptBin "rofi_powermenu" (builtins.readFile ./scripts/desktop/rofi_powermenu))
      (pkgs.writeScriptBin "wacom.sh" (builtins.readFile ./scripts/desktop/wacom.sh))
    ]);

    file = {
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

      ".config/wofi/config".source = ./files/woficonfig;
      ".config/wofi/style.css".source = ./files/wofi.css;
      ".config/wofi/style.css".executable = true;

      ".config/doom/".source = pkgs.symlinkJoin {
        name = "doom-config";
        paths = [
          doom-dots
        ];
      };

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

    bat.enable = true;

    lazygit.enable = true;

    zathura.enable = true;

    mpv.enable = true;
  };

  gtk = {
    enable = true;
    catppuccin = {
      size = "compact";
      tweaks = [ "rimless" ];
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
      name = "DokiDokiMono Nerd Font";
      package = dokidokimono;
      size = 12;
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  services = {
    gammastep = {
      enable = true;
      enableVerboseLogging = true;
      longitude = 57.708870;
      latitude = 11.974560;
    };

    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };

    picom = lib.mkIf desktop {
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
  };



  systemd.user = lib.mkIf laptop {
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
    services = {
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
                elif [ "$status" = Discharging -a "$capacity" -le 20 ]; then
                  notify-send "Battery Low: $battery_percentage"
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

  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "pink";
  };

  news.display = "silent";
  programs.home-manager.enable = true;

}
