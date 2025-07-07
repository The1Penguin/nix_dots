{ config, lib, pkgs, ... }:

let dokidokimono = import ./dokidokimono.nix { inherit pkgs; }; in

{
  programs.kitty = {
    enable = true;
    font = {
      name = "DokiDokiMono Nerd Font";
      package = dokidokimono;
      size = 16;
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      window_padding_width = "2 3";
      background_opacity = 0.93;
    };
  };
}
