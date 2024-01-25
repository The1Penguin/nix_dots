{ config, lib, pkgs, spicetify-nix, nur, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
  doom-dots = pkgs.fetchFromGitHub {
    owner = "The1Penguin";
    repo = "dotemacs";
    rev = "18befcf8579ca205c7226471dc385dfc766e4fee";
    hash = "sha256-9uS5WW7/j1l+i/4DPdmrxhuZQ9C1VGoSPDLIJidWa2o=";
    fetchSubmodules = true;
  };
in
{

  imports = [ spicetify-nix.homeManagerModule ];

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "23.05";

    # Packages for my user
    packages = with pkgs; [
      htop
      emacs29-gtk3
      nextcloud-client
      # firefox
      kate
      pavucontrol
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      ranger
      wofi
      eza
      bitwarden
      playerctl
      brightnessctl
      pulseaudio
      libnotify
      gcc
      xfce.thunar
      ranger
      bat
      acpi
      swaylock-effects
      agda
      cmake
      gnumake
      libtool
      sqlite
      sway-contrib.grimshot
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
      moonlight-qt
      python3
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science sv ]))
      ripgrep
      texlive.combined.scheme-full
      (lutris.override {
        extraPkgs = lutrisPkgs: [
          wineWowPackages.waylandFull
          winetricks
          libnghttp2
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
    ] ++
    # Own scripts
    [
      (pkgs.writeScriptBin "notify" (builtins.readFile ./scripts/notify))
      (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile ./scripts/wofi_powermenu_w))
      (pkgs.writeScriptBin "mylock" (builtins.readFile ./scripts/mylock))
    ];

    file = {
      ".config/river/init".source = ./files/riverconfig;
      ".config/river/init".executable = true;

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

      ".config/bat/themes/Catppuccin-latte.tmTheme".source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
        sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
      } + "/Catppuccin-latte.tmTheme";

      ".config/fish/themes/Catppuccin Latte.theme".source = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "fish";
            rev = "91e6d6721362be05a5c62e235ed8517d90c567c9";
            sha256 = "sha256-l9V7YMfJWhKDL65dNbxaddhaM6GJ0CFZ6z+4R6MJwBA=";
          } + "/themes/Catppuccin Latte.theme";

      # ".mozilla/firefox/profiles.ini".source = ./files/firefox.profile;
      # ".mozilla/firefox/pingu/chrome/userChrome.css".source = ./files/firefox.css;

    };

    # Enable cursor
    pointerCursor = {
      name = "Capitaine";
      package = pkgs.capitaine-cursors;
      size = 32;
      x11 = {
        enable = true;
        defaultCursor = "capitaine-cursors";
      };
    };
  };

  # Default folders
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
    # Git options
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

    # Neovim is now here
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        catppuccin-nvim
        FTerm-nvim
        supertab
        vim-startify
        nvim-surround
        vim-autoformat
        vimtex
        nvim-comment
        nvim-treesitter.withAllGrammars
        lazygit-nvim
        vim-gitgutter
        vim-fugitive
        vim-css-color
        vim-devicons
        nvim-tree-lua
        lualine-nvim
        nvim-web-devicons
      ];
      extraConfig = (builtins.readFile ./files/nvimscript);
      extraLuaConfig = (builtins.readFile ./files/nvimlua);
      coc.enable = true;
    };

    # Fancy terminals ^ㅂ^
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

    fish = {
      enable = true;
      shellAliases = {
        ":q" = "exit";
        "q" = "exit";
        "vim" = "nvim";
        "emacs" = "emacsclient -nw -c -a \"\"";
        "ls" = "eza --icons --group-directories-first";
        "ll" = "eza -alF --icons --group-directories-first";
        "b" = "bluetoothctl";
      };

      shellInit = ''
        if command -q sk
            skim_key_bindings
        end
        set fish_greeting
        export MANPAGER="bat -p"
        export PAGER="bat"
        export BAT_THEME="Catppuccin-latte"
      '';

      interactiveShellInit = ''
        any-nix-shell fish | source
      '';

      plugins = [
        {
          name = "sudope";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-sudope";
            rev = "83919a692bc1194aa322f3627c859fecace5f496";
            sha256 = "sha256-pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
          };
        }
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "latte";

      enabledCustomApps = with spicePkgs.apps; [
        lyrics-plus
      ];

      enabledExtensions = with spicePkgs.extensions; [
        keyboardShortcut
        trashbin
        fullAlbumDate
        history
        powerBar
        playlistIcons
        fullAppDisplayMod
      ];
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

    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 5;
            y = 3;
          };
          title = "Alacritty";
          dynamic_title = false;
          opacity = 0.93;
        };

        scrolling = {
          multiplier = 1;
        };

        font = {
          normal = {
            family = "Fira Code";
            style  = "Regular";
          };
          bold = {
            family = "Fira Code";
            style  = "Bold";
          };
          italic = {
            family = "Fira Code";
            style  = "Italic";
          };
          bold_italic = {
            family = "Fira Code";
            style  = "Bold Italic";
          };
          size = 14.0;
        };

        shell = {
          program = "fish";
        };

        colors = {
          primary = {
            background        = "#EFF1F5";
            foreground        = "#4C4F69";
            dim_foreground    = "#4C4F69";
            bright_foreground = "#4C4F69";
          };
          cursor = {
            text   = "#EFF1F5";
            cursor = "#DC8A78";
          };
          vi_mode_cursor = {
            text   = "#EFF1F5";
            cursor = "#7287FD";
          };
          search = {
            matches = {
              foreground = "#EFF1F5";
              background = "#6C6F85";
            };
            focused_match = {
              foreground = "#EFF1F5";
              background = "#40A02B";
            };
          };

          footer_bar = {
            foreground = "#EFF1F5";
            background = "#6C6F85";
          };

          hints = {
            start = {
              foreground = "#EFF1F5";
              background = "#DF8E1D";
            };
            end = {
              foreground = "#EFF1F5";
              background = "#6C6F85";
            };
          };

          selection = {
            text       = "#EFF1F5";
            background = "#DC8A78";
          };

          normal = {
            black   = "#5C5F77";
            red     = "#D20F39";
            green   = "#40A02B";
            yellow  = "#DF8E1D";
            blue    = "#1E66F5";
            magenta = "#EA76CB";
            cyan    = "#179299";
            white   = "#ACB0BE";
          };

          bright = {
            black   = "#6C6F85";
            red     = "#D20F39";
            green   = "#40A02B";
            yellow  = "#DF8E1D";
            blue    = "#1E66F5";
            magenta = "#EA76CB";
            cyan    = "#179299";
            white   = "#BCC0CC";
          };

          dim = {
            black   = "#5C5F77";
            red     = "#D20F39";
            green   = "#40A02B";
            yellow  = "#DF8E1D";
            blue    = "#1E66F5";
            magenta = "#EA76CB";
            cyan    = "#179299";
            white   = "#ACB0BE";
          };

          indexed_colors = [
            { index = 16; color = "#FE640B"; }
            { index = 17; color = "#DC8A78"; }
          ];
        };
      };
    };

    firefox = {
      enable = true;
      profiles.pingu = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          betterttv
          bitwarden
          bypass-paywalls-clean
          consent-o-matic
          # clickbait-remover-for-youtube
          darkreader
          duckduckgo-privacy-essentials
          enhancer-for-youtube
          firefox-color
          foxyproxy-standard
          # jiffy-reader
          new-tab-override
          # new-xkit
          old-reddit-redirect
          privacy-badger
          reddit-enhancement-suite
          refined-github
          sidebery
          sponsorblock
          stylus
          tampermonkey
          ublock-origin
          vimium
        ];
        isDefault = true;
        userChrome = (builtins.readFile ./files/firefox.css);
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.toolbars.bookmarks.visibility" = "never";
        };
      };
    };
  };

  # Enable correct gtk themes and such
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
  };

  services.gammastep = {
    enable = true;
    # dawnTime =
    # duskTime =
    enableVerboseLogging = true;
    longitude = 57.708870;
    latitude = 11.974560;
  };

  programs.home-manager.enable = true;

}
