{ config, lib, pkgs, ... }:

{
  imports = [
    ./namespaced-wg.nix
  ];

  # Set up wireguard + a new network namespace using the module defined in hardware-configuration.nix
  services.namespaced-wg.enable = true;
  services.namespaced-wg.name = "vpn"; # Name this whatever, but keep it short
  services.namespaced-wg.ips = [ "10.69.137.229/32" ];
  services.namespaced-wg.peerPublicKey = "KkShcqgwbkX2A9n1hhST6qu+m3ldxdJ2Lx8Eiw6mdXw=";
  services.namespaced-wg.peerEndpoint = "146.70.117.226:51820";
  services.namespaced-wg.privateKeyFile = "../../secrets/wgMullvad.conf";
  services.namespaced-wg.hostPortalIp = "10.69.44.1"; # Use a different subnet than your LAN
  services.namespaced-wg.guestPortalIp = "10.69.44.2";
}
