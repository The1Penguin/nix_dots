# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

args@{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../software/adb.nix
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
      ../software/joycond.nix
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
      ../software/steam.nix
      ../software/swaylock.nix
      ../software/tailscale.nix
      ../software/tkey.nix
      ../software/wallet.nix
      (import ../software/xdg.nix (args // { fps = 60; }))
      ../software/zsa.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.initrd.luks.devices."luks-ec893630-d23c-4bd3-b855-18be312aff5e".device = "/dev/disk/by-uuid/ec893630-d23c-4bd3-b855-18be312aff5e";

  # Above is auto generated

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Host name and enabling networkmanager
  networking.hostName = "scorpia";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.initrd.enable = true;
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

  # Mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.displayManager.sddm.wayland = {
    enable = true;
    compositor = lib.mkForce "kwin";
  };

  services.fwupd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
