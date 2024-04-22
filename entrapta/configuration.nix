# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../general-system.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "entrapta"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "chili";
    windowManager.bspwm.enable = true;
    libinput.mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
    };
    monitorSection = ''
      # HorizSync source: edid, VertRefresh source: edid
      VendorName     "Unknown"
      ModelName      "Acer XF240H"
      HorizSync       180.0 - 180.0
      VertRefresh     48.0 - 146.0
      Option         "DPMS"
    '';
    deviceSection = ''
      Driver         "nvidia"
      VendorName     "NVIDIA Corporation"
      BoardName      "NVIDIA GeForce GTX 1070 Ti"
    '';
    screenSection = ''
      DefaultDepth    24
      Option         "Stereo" "0"
      Option         "nvidiaXineramaInfoOrder" "DP-4"
      Option         "metamodes" "DP-0: 1920x1080_144 +1920+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-4: 1920x1080_144 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      Option         "SLI" "Off"
      Option         "MultiGPU" "Off"
      Option         "BaseMosaic" "off"
      SubSection     "Display"
          Depth       24
      EndSubSection
    '';
  };

  services.openssh = {
    enable = true;
    ports = [ 69 ];
    settings.PasswordAuthentication = false;
  };

  environment.systemPackages = with pkgs; [
    dunst
    feh
    picom
    sddm-chili-theme
  ];

  hardware.enableAllFirmware = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
