# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

args@{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../software/appimage.nix
      ../software/audio.nix
      ../software/bash.nix
      ../software/bluetooth.nix
      ../software/cachix.nix
      ../software/catppuccin.nix
      ../software/dbus.nix
      (import ../software/displaymanager.nix (args // { defaultSession = "river"; }))
      ../software/doas.nix
      ../software/docker.nix
      ../software/editor.nix
      ../software/fish.nix
      ../software/fonts.nix
      ../software/git.nix
      ../software/graphics.nix
      ../software/kanata.nix
      ../software/locale.nix
      ../software/networkd.nix
      ../software/niri.nix
      ../software/nix.nix
      ../software/ozone.nix
      ../software/pingu.nix
      ../software/plasma.nix
      ../software/polkit.nix
      ../software/powerkey.nix
      ../software/power-profiles.nix
      ../software/printer.nix
      ../software/river.nix
      ../software/swaylock.nix
      ../software/tailscale.nix
      ../software/tkey.nix
      ../software/wallet.nix
      (import ../software/xdg.nix (args // { fps = 60; }))
      ../software/zsa.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-754fdd9f-2361-419d-92c9-57d04ce22aec".device = "/dev/disk/by-uuid/754fdd9f-2361-419d-92c9-57d04ce22aec";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Host name and enabling networkmanager
  networking.hostName = "shadowweaver";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.upower.enable = true;
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
  powerManagement.powertop.enable = true;
  services.tlp.enable = lib.mkForce false;

  services.displayManager.sddm.wayland = {
    enable = true;
    compositor = lib.mkForce "kwin";
  };

  services.fwupd.enable = true;

  # Secure boot
  environment.systemPackages = [ pkgs.sbctl ];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      autoReboot = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
