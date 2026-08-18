{ config, lib, pkgs, ... }:

let minutes = x: x * 60; in
{
  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" ];
    timeouts = [
      { timeout = minutes 4; command = "${pkgs.mylock}/bin/mylock"; }
      { timeout = minutes 10; command = "systemctl suspend"; }
    ];
  };
}
