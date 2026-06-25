{ config, lib, pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
      trusted-users = [ "root" "pingu" ];
      extra-substituters = [
        "https://cache.lix.systems"
      ];
      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      ];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
