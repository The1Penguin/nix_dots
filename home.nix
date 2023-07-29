{ config, lib, pkgs, ... }:
{

  home = {
    username = "pingu";
    homeDirectory = "/home/pingu";
    stateVersion = "23.05";

    # Packages for my user
    packages = with pkgs; [
      htop
      emacs
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
      direnv
      (remmina.override { freerdp = (freerdp.override { openssl = pkgs.openssl_1_1; }); })
      kotatogram-desktop
      nixpkgs-fmt
      zathura
      lazygit
      xivlauncher
      speedtest-rs
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

      # ".config/fish/config.fish".source = ./files/config.fish;

      ".doom.d/".source = pkgs.fetchFromGitHub {
        owner = "The1Penguin";
        repo = "dotemacs";
        rev = "1d00b0f11626352cfc27a3cb2c4b242f220aa411";
        sha256 = "sha256-4fyzZP1DyzW3yVAUn3WQxZwJlrh3LiSt20C1sPB3cwM=";
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
      ":q"    = "exit";
      "q"     = "exit";
      "vim"   =  "nvim";
      "emacs" = "emacsclient -nw -c -a \"\"";
      "ls"    = "exa --icons --group-directories-first";
      "ll"    = "exa -alF --icons --group-directories-first";
      "b"     = "bluetoothctl";
    };

    shellInit = ''
      if command -q sk
          skim_key_bindings
      end
      set fish_greeting
      export MANPAGER="bat -p"
      export PAGER="bat"
    '';
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
