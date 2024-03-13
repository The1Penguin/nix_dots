{ config, lib, pkgs, spicetify-nix, nur, desktop, laptop, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "b420faf2915b6cf93a57ddfe9aacb093da4a052f";
    hash = "sha256-1JKTPdiTyMRYxVregGGAbsP8cC763ntea8EP6Mz4pRc=";
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
      emacs29-gtk3
      nextcloud-client
      kate
      pavucontrol
      (pkgs.discord.override {
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
      any-nix-shell
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

    starship = {
      enable = true;
      settings = {
        format = "$nix_shell$directory";
        right_format = "$hostname";
        add_newline = false;

        hostname = {
          ssh_only = true;
          format = "[$hostname](bold yellow)";
        };

        directory = {
          truncation_length = 0;
          truncation_symbol = "…/";
          truncate_to_repo = false;
          read_only = " 🔒";
          style = "cyan";
        };
        nix_shell = {
          symbol = " ";
          format = "[$symbol$name]($style) ";
          style = "bright-purple bold";
        };
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd cd" ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
        obs-webkitgtk
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

  programs.home-manager.enable = true;

}
