{ config, lib, pkgs, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
in
{

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "23.11";

    # Packages for my user
    packages = with pkgs; [
      htop
      emacs29
      nextcloud-client
      firefox
      kate
      pavucontrol
      alacritty
      discord
      ranger
      wofi
      spotify
      exa
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
      neofetch
      sway-contrib.grimshot
      mpv
      jellyfin-media-player
      signal-desktop
      qview
      (remmina.override { freerdp = (freerdp.override { openssl = pkgs.openssl_1_1; }); })
      kotatogram-desktop
      nixpkgs-fmt
      zathura
      lazygit
      xivlauncher
      speedtest-rs
      any-nix-shell
      moonlight-qt
      python3
      gamescope
      lutris
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science sv ]))
      ripgrep
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

      ".config/alacritty/alacritty.yml".source = ./files/alacritty.yml;
      ".config/alacritty/alacrittycolors.yml".source = ./files/alacrittycolors.yml;

      ".config/mako/config".source = ./files/makoconfig;

      ".config/doom/".source = pkgs.fetchFromGitHub {
        owner = "The1Penguin";
        repo = "dotemacs";
        rev = "c08b564fb324c6abd1c4a8e349e27e1361333260";
        sha256 = "sha256-s6Tii1vF6sON8Dxj/CTlWT0EpSCw4U92xAtrYN5xovA=";
      };

      ".mozilla/firefox/debyy83g.default/chrome/userChrome.css".source = ./files/firefox.css;

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

  # Git options
  programs.git = {
    enable = true;
    userName = "pingu";
    userEmail = "nor@acorneroftheweb.com";
  };

  # Neovim is now here
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      dracula-nvim
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


  # Enable correct gtk themes and such
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
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
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Fancy terminals ^ㅂ^
  programs.starship = {
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

  # services.emacs.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      ":q" = "exit";
      "q" = "exit";
      "vim" = "nvim";
      "emacs" = "emacsclient -nw -c -a \"\"";
      "ls" = "exa --icons --group-directories-first";
      "ll" = "exa -alF --icons --group-directories-first";
      "b" = "bluetoothctl";
    };

    shellInit = ''
      if command -q sk
          skim_key_bindings
      end
      set fish_greeting
      export MANPAGER="bat -p"
      export PAGER="bat"
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Use Vencord and OpenASAR on discord
  nixpkgs.overlays =
    let
      myOverlay = self: super: {
        discord = super.discord.override { withOpenASAR = true; withVencord = true; };
      };
    in
    [ myOverlay ];

  programs.home-manager.enable = true;

}
