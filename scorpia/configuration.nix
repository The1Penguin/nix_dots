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

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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

  programs.river.enable = true;

  services.tlp.enable = true;

  # Mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.displayManager.sddm.wayland = {
    enable = true;
    compositor = lib.mkForce "kwin";
  };

  # Allow for brightness control
  programs.light.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
