args@{ config, lib, pkgs, spicetify-nix, nixos-xivlauncher-rb, desktop, laptop, server, wayland, x, secrets, ... }:
let
  username = "pingu";
  homeDir = "/home/${username}";
in
{

  imports = [
    ./software/fish.nix
    ./software/neovim.nix
    ./software/git.nix
    ./software/hyfetch.nix
    (import ./software/syncthing.nix (args // { homeDir = homeDir; }))
    ./software/emacs.nix
  ] ++ (lib.optionals (!server) [
    ./software/foot.nix
    ./software/alacritty.nix
    ./software/librewolf.nix
    ./software/spotify.nix
    ./software/thunderbird.nix
    ./software/mpv.nix
    ./software/tkey.nix
    ./software/posture.nix
    ./software/hydration.nix
    ./software/gtk.nix
  ]) ++ (lib.optionals desktop [
    ./software/obs.nix
  ]) ++ (lib.optionals laptop [
    ./software/battery.nix
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
      python3
      fd
      pulsemixer
      eza
      pulseaudio
      gcc
      nixpkgs-fmt
      speedtest-rs
      ripgrep
      unzip
      nurl
      killall
      any-nix-shell
      nixd
      powertop
      dua
      openjdk
      languagetool
    ] ++
    (lib.optionals (!server) [
      pavucontrol
      stable.vesktop
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
      keymapp
      gcr
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

    bat.enable = true;

    lazygit.enable = true;

    zathura.enable = true;

    zellij.enable = true;

    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings.manager.sort_dir_first = true;
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

    gnome-keyring.enable = true;
  };


  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "pink";
  };

  news.display = "silent";
  programs.home-manager.enable = true;

}
