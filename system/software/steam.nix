{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extest.enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamescope.enable = true;

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility"; # For systems with AMD GPUs
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };
}
