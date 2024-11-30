# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

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

  services.libinput.mouse = {
    accelProfile = "flat";
    accelSpeed = "0";
  };
  services.ratbagd.enable = true;

  programs.river.enable = true;

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];


  services.openssh = {
    enable = true;
    ports = [ 69 ];
    settings = {
      PasswordAuthentication = false;
      LoginGraceTime = 0;
    };
  };

  hardware.enableAllFirmware = true;

  services.displayManager.sddm.wayland = {
    enable = true;
    compositor = lib.mkForce "kwin";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
