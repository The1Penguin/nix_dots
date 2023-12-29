# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "hid-nintendo" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/0b8bd317-b73f-482f-90b1-5c16d71c4b02";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-3ea94c00-8072-4321-8f4f-2f9400018638".device = "/dev/disk/by-uuid/3ea94c00-8072-4321-8f4f-2f9400018638";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/4CB6-9FC5";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/73f92b6f-e468-470d-9251-ea3cff378816"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
