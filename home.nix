{ config, lib, pkgs, spicetify-nix, any-nix-shell, nixos-xivlauncher-rb, desktop, laptop, server, wayland, x, secrets, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "af1d35abb7611cec63bf24d9300ebaabed8240f2";
    hash = "sha256-feQH6Jkbvk6dC2ynyKZedPwO8oqCBk/AnIMYC+aqm3k=";
    fetchSubmodules = true;
  };
  dokidokimono = import ./software/dokidokimono.nix { inherit pkgs; };
in
{

  imports = [
    ./software/fish.nix
    ./software/neovim.nix
  ] ++ (lib.optionals (!server) [
    ./software/wezterm.nix
    ./software/librewolf.nix
    ./software/spotify.nix
    ./software/thunderbird.nix
    ./software/mpv.nix
  ]) ++ (lib.optionals wayland [
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
      emacs-pgtk
      python3
      fd
      pulsemixer
      ranger
      eza
      pulseaudio
      gcc
      ranger
      (agda.withPackages (p: with p; [
        standard-library
      ]))
      cmake
      gnumake
      libtool
      sqlite
      nixpkgs-fmt
      speedtest-rs
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science sv ]))
      ripgrep
      unzip
      nurl
      killall
      any-nix-shell.outputs.packages.x86_64-linux.any-nix-shell
      git-crypt
      nixd
    ] ++
    (lib.optionals (!server) [
      pavucontrol
      stable.vesktop
      #(discord.override {
      #  withOpenASAR = true;
      #  withVencord = true;
      #  withTTS = false;
      #})
      bitwarden
      playerctl
      libnotify
      xfce.thunar
      jellyfin-media-player
      signal-desktop
      qview
      kdePackages.krdc
      remmina
      kotatogram-desktop
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
      networkmanagerapplet
      fallout-ce
      feishin
      cockatrice
      trayscale
      itch
      teams-for-linux
      feishin
    ]) ++
    (lib.optionals desktop [
      piper
      openmw
      (nixos-xivlauncher-rb.packages.x86_64-linux.xivlauncher-rb.override {
        useGameMode = true;
      })
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
      size = 30;
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
        obs-vkcapture
        wlrobs
        obs-tuna
        obs-scale-to-sound
      ];
    };

    bat.enable = true;

    lazygit.enable = true;

    zathura.enable = true;
  };

  catppuccin.gtk = {
    size = "compact";
    tweaks = [ "rimless" ];
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 30;
    };
    iconTheme = {
      name = "Zafiro-icons";
      package = pkgs.zafiro-icons;
    };
    gtk3 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=0
          gtk-dialogs-use-header=false
        '';
        extraCss = ''
          headerbar.default-decoration {
            margin-bottom: 50px;
            margin-top: -100px;
          }
          window.csd,             /* gtk4? */
          window.csd decoration { /* gtk3 */
            box-shadow: none;
          }
        '';
      };
    };
    gtk4 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=0
          gtk-dialogs-use-header=false
        '';
      };
      extraCss = ''
        headerbar.default-decoration {
          margin-bottom: 50px;
          margin-top: -100px;
        }
        window.csd,             /* gtk4? */
        window.csd decoration { /* gtk3 */
          box-shadow: none;
        }
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

  services = lib.mkIf (!server) {
    gammastep = {
      enable = true;
      enableVerboseLogging = true;
      longitude = 57.708870;
      latitude = 11.974560;
    };

    nextcloud-client = {
      enable = false;
      startInBackground = true;
    };

    syncthing = {
      enable = true;
      settings = {
        devices.catra = {
          addresses = [ "tcp://sync.acorneroftheweb.com" ];
          id = secrets.syncthing.catra;
        };
        devices.entrapta = {
          addresses = [ "dynamic" ];
          id = secrets.syncthing.entrapta;
        };
        devices.scorpia = {
          addresses = [ "dynamic" ];
          id = secrets.syncthing.scorpia;
        };
        devices.glimmer = {
          addresses = [ "dynamic" ];
          id = secrets.syncthing.glimmer;
        };
        folders.Main = {
          path = "${homeDir}/.syncthing";
          devices = [ "catra" "entrapta" "scorpia" ];
          versioning = {
            type = "simple";
            params.keep = "5";
            params.cleanoutDays = "15";
          };
        };
        folders.Pictures = {
          path = "${homeDir}/pic";
          devices = [ "catra" "entrapta" "scorpia" "glimmer" ];
          versioning = {
            type = "simple";
            params.keep = "5";
            params.cleanoutDays = "15";
          };
        };
        options.localAnnounceEnabled = false;
        options.urAccepted = -1;
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
