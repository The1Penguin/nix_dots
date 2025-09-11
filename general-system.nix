{ config, lib, pkgs, server, x, wayland, ... }:
let dokidokimono = import ./software/dokidokimono.nix { inherit pkgs; }; in
{

  imports = [
    ./software/kanata.nix
    ./hardware/tkey.nix
  ];

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  console.keyMap = "sv-latin1";

  services.printing.enable = lib.mkIf (!server) true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
      trusted-users = [ "root" "pingu" ];
      extra-substituters = [
        "https://cache.lix.systems"
      ];
      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      ];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    git-crypt
    bash
    xdg-utils
    cachix
    doas-sudo-shim
    (writeShellScriptBin "doasedit" (builtins.readFile scripts/doasedit))
    (writeShellScriptBin "sudoedit" (builtins.readFile scripts/doasedit))
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.xkb = {
    layout = "sebrackets";
    extraLayouts.sebrackets = {
      description = "SE with better brackets added";
      languages = [ "swe" ];
      symbolsFile = ./files/selayout;
    };
  };

  services.xserver.wacom.enable = lib.mkIf x true;

  services.joycond.enable = lib.mkIf (!server) true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
    package = pkgs.bluez-experimental;
  };

  hardware.keyboard.zsa.enable = true;

  services.power-profiles-daemon.enable = lib.mkForce false;

  programs.river-classic.enable = wayland;
  programs.niri = lib.mkIf wayland {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.displayManager = {
    defaultSession = if wayland then "river" else "bspwm";
    sddm = lib.mkIf (!server) {
      enable = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
    };
  };

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    kate
  ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.monofur
    nerd-fonts.zed-mono
    nerd-fonts.symbols-only
    dokidokimono
  ];

  programs.fish.enable = true;
  environment.pathsToLink = [ "/share/fish" ];

  environment.variables = { EDITOR = "vim"; };

  security.polkit.enable = true;
  security.rtkit.enable = true;
  systemd.services = {
    NetworkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };
  services.dbus = {
    enable = true;
    implementation = "broker";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = [ "wlr" ];
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };

  users.users.pingu = {
    isNormalUser = true;
    description = "pingu";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "uinput" "tkey" ];
    shell = pkgs.fish;
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        runAs = "root";
        groups = [ "wheel" ];
        persist = true;
        noPass = false;
        keepEnv = true;
      }];
    };
  };

  programs.adb.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  programs.steam = lib.mkIf (!server) {
    enable = true;
    extest.enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamescope.enable = true;

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility"; # For systems with AMD GPUs
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "pink";
    sddm = {
      background = ./sakuraflower.png;
      font = "DokiDokiMono Nerd Font";
    };
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

}
