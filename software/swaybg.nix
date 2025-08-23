{ config, lib, pkgs, wallpaper, ... }:

{
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper daemon for Wayland";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${wallpaper}";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
