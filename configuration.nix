# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-64878b92-146a-44ce-b3de-0dc1f3ccb697".device = "/dev/disk/by-uuid/64878b92-146a-44ce-b3de-0dc1f3ccb697";
  boot.initrd.luks.devices."luks-64878b92-146a-44ce-b3de-0dc1f3ccb697".keyFile = "/crypto_keyfile.bin";

  # Above is auto generated

  # Host name and enabling networkmanager
  networking.hostName = "scorpia";
  networking.networkmanager.enable = true;

  # Hardware things such as opengl and bluetooth
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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

  # Enable sound settings
  sound.enable = true;
  security.rtkit.enable = true;
  # Use pipe wire for most things
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing stuffs
  services.printing.enable = true;

  # Locale settings
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

  # Add custom keyboard layout
  services.xserver.extraLayouts.sebrackets = {
    description = "SE with better brackets added";
    languages = [ "swe" ];
    symbolsFile = ./files/selayout;
  };

  # Install systemwide packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];
  environment.systemPackages = with pkgs; [
    vim
    git
    wayland
    river
    rivercarro
    mako
    kanshi
    bash
    swaybg
    xdg-utils
    xwayland
  ];


  # Steamy stuffs
  programs.steam.enable = true;

  # Mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Fonts that can be used
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    nerdfonts
  ];

  # Login session thingy
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd river
      '';
    };
  };

  # Enable me as a user
  users.users.pingu = {
    isNormalUser = true;
    description = "pingu";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
  programs.fish.enable = true;

  # Setting vim as the defualt editor
  environment.variables = { EDITOR = "vim"; };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Allow for brightness control
  programs.light.enable = true;
  # stuff that just kinda works or is needed
  security.polkit.enable = true;
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
  };
  services.dbus = {
    enable = true;
    implementation = "broker";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
