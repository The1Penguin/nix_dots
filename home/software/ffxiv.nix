{ config, lib, pkgs, nixos-xivlauncher-rb, ... }:

{
  home.packages = [
    (nixos-xivlauncher-rb.packages.x86_64-linux.xivlauncher-rb.override {
      useGameMode = true;
    })
    (pkgs.writeScriptBin "ffxiv-backup" (builtins.readFile ../../scripts/desktop/ffxiv-backup))
    (pkgs.writeScriptBin "ffxiv-update" (builtins.readFile ../../scripts/desktop/ffxiv-update))
  ];
}
