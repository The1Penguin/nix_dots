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

  networking.hostName = "adora"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.openssh = {
    enable = true;
    ports = [ 69 ];
    settings = {
      PasswordAuthentication = false;
      LoginGraceTime = 0;
    };
  };

  services.udev.extraRules = ''
      SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTR{index}=="0", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="0893", RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d $devnode --set-fmt-video=width=1920,height=1080,pixelformat=YUYV"
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
