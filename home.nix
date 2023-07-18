{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball {
        url = "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
        sha256 = "0dfshsgj93ikfkcihf4c5z876h4dwjds998kvgv7sqbfv0z6a4bc";
    };
in
{
  imports = [
      (import "${home-manager}/nixos")
  ];

  home-manager.users.pingu = {
    home.stateVersion = "23.05";

    # Packages for my user
    home.packages = with pkgs; [
        htop
        emacs
        neovim
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
    ] ++
    # Own scripts
    [
        (pkgs.writeScriptBin "notify" ''
            #!/usr/bin/env sh
            TIME=$(date "+%H:%M")
            battery_stat="$(acpi --battery)"
            battery_greped_status="$(echo $battery_stat | cut -d',' -f1 | cut -d':' -f2 | xargs | awk '{print tolower($0)}')"
            battery_percentage_v="$(echo $battery_stat | grep -Po '(\d+%)' | grep -Po '\d+')"
            network="$(nmcli -t -f name connection show --active | sed 's/lo/not connected/' | head -n 1)"


            notify-send 'Status' "$(echo -e "Time: $TIME \n\
            Network: $network \n\
            Battery: $battery_percentage_v%, and $battery_greped_status")"
            '')
        (pkgs.writeScriptBin "wofi_powermenu_w" ''
            #!/usr/bin/env sh

            # options to be displayed
            option0="logout"
            option1="reboot"
            option2="shutdown"

            # options passed into variable
            options="$option0\n$option1\n$option2"

            chosen="$(echo -e "$options" | wofi -lines 3 --show=dmenu -p "power")"
            case $chosen in
                $option0)
                    riverctl exit;;
                $option1)
                    systemctl reboot;;
                $option2)
                    systemctl poweroff;;
            esac
            '')
        (pkgs.writeScriptBin "mylock" ''
            #!/usr/bin/env sh

            swaylock \
                  --screenshots \
                  --clock \
                  --datestr "%a, %d/%m/%y" \
                  --indicator \
                  --indicator-radius 100 \
                  --indicator-thickness 7 \
                  --effect-blur 7x5 \
                  --effect-vignette 0.5:0.5 \
                  --ring-color bb00cc \
                  --key-hl-color 50fa7b \
                  --line-color 00000000 \
                  --inside-color 282a36 \
                  --separator-color 50fa7b \
                  --ring-color 00000000 \
                  --text-color f8f8f8ff \
                  --text-ver-color f8f8f8ff \
                  --text-wrong-color f8f8ff \
                  --inside-ver-color 282a36 \
                  --inside-wrong-color 282a36 \
                  --ring-ver-color 00000000 \
                  --ring-wrong-color 00000000 \
                  --line-ver-color 00000000 \
                  --line-wrong-color 00000000
            '')
    ];

    home.file = {
      ".config/river/init".source = ./configfiles/riverconfig;
      ".config/river/init".executable = true;

      ".config/kanshi/config".source = ./configfiles/kanshiconfig;

      ".config/wofi/config".source = ./configfiles/woficonfig;
      ".config/wofi/style.css".source = ./configfiles/wofi.css;
      ".config/wofi/style.css".executable = true;


      ".config/alacritty/alacritty.yml".source = ./configfiles/alacritty.yml;
      ".config/alacritty/alacrittycolors.yml".source = ./configfiles/alacrittycolors.yml;

      ".config/mako/config".source = ./configfiles/makoconfig;

      ".config/fish/config.fish".source = ./configfiles/config.fish;

      ".config/nvim/init.lua".source = ./configfiles/nvimconfig;

      ".doom.d/" = {
        source = ./dotemacs;
        recursive = true;
      };

      ".mozilla/firefox/debyy83g.default/chrome/userChrome.css".source = ./configfiles/firefox.css;

    };

    # Git options
    programs.git = {
        enable = true;
        userName  = "pingu";
        userEmail = "nor@acorneroftheweb.com";
    };

    # Lazy way of using the plugins that I am used to until I transfer them
    # to this config
    programs.neovim.plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    # Enable cursor
    home.pointerCursor = {
      name = "Capitaine";
      package = pkgs.capitaine-cursors;
      size = 32;
      x11 = {
        enable = true;
        defaultCursor = "capitaine-cursors";
      };
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

  # Set default shell to fish for me
  programs.fish.enable = true;
  users.users.pingu.shell = pkgs.fish;
  # services.emacs.enable = true;

  # Use Vencord and OpenASAR on discord
  nixpkgs.overlays =
    let
      myOverlay = self: super: {
        discord = super.discord.override { withOpenASAR = true; withVencord = true; };
      };
    in
    [ myOverlay ];

  # Steamy stuffs
  programs.steam.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
