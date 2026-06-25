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
      ../software/river.nix
      ../software/steam.nix
      ../software/swaylock.nix
      ../software/tailscale.nix
      ../software/tkey.nix
      ../software/wallet.nix
      (import ../software/xdg.nix (args // { fps = 144; }))
      ../software/zsa.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  services.openssh = {
    enable = true;
    ports = [ 69 ];
    settings = {
      PasswordAuthentication = false;
      LoginGraceTime = 0;
    };
  };

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu = {
      initrd.enable = true;
      overdrive.enable = true;
    };
  };

  services.lact.enable = true;

  services.displayManager.sddm.wayland = {
    enable = true;
    compositor = lib.mkForce "kwin";
  };

  # Disable wakeup-triggers from specific mouse
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "40-disable-wakeup-mouse.rules";
      destination = "/lib/udev/rules.d/40-disable-wakeup-mouse.rules";
      text = ''
        ACTION=="add|change", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c539", ATTR{power/wakeup}="disabled"
      '';
    })
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
