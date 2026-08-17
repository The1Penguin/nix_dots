{ config, lib, pkgs, ... }:

let minutes = x : x * 60; in
{
  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" "-d" ];
    timeouts = [
      { timeout = minutes 4; command = "${pkgs.mylock}/bin/mylock"; }
      { timeout = minutes 10; command = "systemctl suspend"; }
    ];
  };
}
