{ config, lib, pkgs, ... }:

{
  imports = [
    ./fallout.nix
    ./itch.nix
    ./lutris.nix
    ./magic.nix
    ./mm.nix
    ./morrowind.nix
    ./prismlauncher.nix
  ];
}
