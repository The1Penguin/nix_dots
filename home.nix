{ config, lib, pkgs, spicetify-nix, nur, any-nix-shell, nixos-xivlauncher-rb, desktop, laptop, wayland, x, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "f671a3cd243035a83f16ddb8fe9ad2f7bc82347d";
    hash = "sha256-bAV/ciaK2hoFA3SVdqpjnMZs3GiZX2QN2mQQdyg6wEk=";
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
    ./software/thunderbird.nix
  ] ++ (lib.optionals wayland [
    ./software/river.nix
  ]) ++ (lib.optionals x [
    ./software/bspwm.nix
  ]);

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "23.05";

    packages = with pkgs; [
      htop
      emacs-gtk
      python3
      fd
      nextcloud-client
      kate
      pavucontrol
      (vesktop.override {
        withMiddleClickScroll = true;
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
      (agda.withPackages (p: with p; [
        standard-library
      ]))
      cmake
      gnumake
      libtool
      sqlite
      jellyfin-media-player
      signal-desktop
      qview
      krdc
      remmina
      stable.kotatogram-desktop
      nixpkgs-fmt
      speedtest-rs
      # any-nix-shell
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
          pkgs.zenity
          gamemode
        ];
      })
      slack
      rnote
      unzip
      networkmanagerapplet
      fallout-ce
      nurl
      killall
      feishin
      any-nix-shell.outputs.packages.x86_64-linux.any-nix-shell
      cockatrice
      trayscale
      #itch
    ] ++
    (lib.optionals desktop [
      piper
      openmw
      (xivlauncher.overrideAttrs (finalAttrs: previousAttrs: {
        postPatch = previousAttrs.postPatch + ''
          substituteInPlace src/XIVLauncher.Core/Components/SettingsPage/Tabs/SettingsTabWine.cs \
            --replace 'libgamemodeauto.so.0' '${pkgs.gamemode.lib}/lib/libgamemodeauto.so.0'
        '';
      }))
      vkbasalt
      mangohud
      (pkgs.writeScriptBin "ffxiv-backup" (builtins.readFile ./scripts/desktop/ffxiv-backup))
      (pkgs.writeScriptBin "ffxiv-update" (builtins.readFile ./scripts/desktop/ffxiv-update))
      prismlauncher
    ]);

    file = {
      ".config/rofi/config.rasi".source = ./files/config.rasi;
      ".local/share/rofi/themes".source = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "rofi";
          rev = "5350da41a11814f950c3354f090b90d4674a95ce";
          hash = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
        } + "/basic/.local/share/rofi/themes";

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
        init.defaultBranch = "main";
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
        backend = "fastfetch";
      };
    };

    fastfetch = {
      enable = true;
      settings = {
        modules = [
          "title"
          "separator"
          "os"
          "kernel"
          "uptime"
          "packages"
          "shell"
          { type = "wm"; format = "{2}"; }
          "cursor"
          "terminal"
          { type = "cpu"; format = "{1}"; }
          { type = "gpu"; format = "{1} {2}"; }
          { type = "terminal"; format = "{5}"; }
          "terminalfont"
          "break"
          "colors"
        ];
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
                  notify-send "Battery Critical: $capacity%\\n Hibernating"
                  sleep 5
                  systemctl hibernate
                elif [ "$status" = Discharging -a "$capacity" -le 5 ]; then
                  notify-send "Battery Critical: $capacity%"
                elif [ "$status" = Discharging -a "$capacity" -le 20 ]; then
                  notify-send "Battery Low: $capacity%"
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
