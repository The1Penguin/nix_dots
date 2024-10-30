{ config, lib, pkgs, ... }:
let dokidokimono = import ./software/dokidokimono.nix { inherit pkgs; }; in
{

  imports = [
    ./software/kanata.nix
  ];

  # boot.kernelPackages = pkgs.linuxPackages_zen;

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

  services.printing.enable = true;

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
    bash
    xdg-utils
    cachix
  ];

  services.xserver.xkb.layout = "se";

  services.xserver.wacom.enable = true;

  services.joycond.enable = true;


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
    package = pkgs.bluez5-experimental;
  };

  services.power-profiles-daemon.enable = lib.mkForce false;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  services.displayManager.sddm = {
    enable = true;
    package = lib.mkForce pkgs.kdePackages.sddm;
    catppuccin = {
      background = ./sakuraflower.png;
      font = "DokiDokiMono Nerd Font";
    };
  };

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
    nerdfonts
    dokidokimono
  ];

  programs.fish.enable = true;
  environment.pathsToLink = [ "/share/fish" ];

  environment.variables = { EDITOR = "vim"; };

  security.polkit.enable = true;
  security.rtkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    services = {
      NetworkManager-wait-online.enable = lib.mkForce false;
      systemd-networkd-wait-online.enable = lib.mkForce false;
    };
  };
  services.dbus = {
    enable = true;
    implementation = "broker";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
  programs.gnupg.agent.enable = true;

  users.users.pingu = {
    isNormalUser = true;
    description = "pingu";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "uinput" ];
    shell = pkgs.fish;
  };
  programs.adb.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      gamemode
    ];
  };

  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "pink";
  };

}
