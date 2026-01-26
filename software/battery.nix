{ config, lib, pkgs, ... }:

{

  systemd.user = {
    timers = {
      battery-check = {
        Unit.Description = "Warn at low battery levels";
        Timer = {
          OnBootSec = "1min";
          OnUnitActiveSec = "30s";
          Unit = "battery-check.service";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
    services = {
      battery-check = {
        Unit.Description = "Warn at low battery levels";
        Service =
          let
            batMon = pkgs.writeShellScript "batMon" ''
              PATH="$PATH:${pkgs.lib.makeBinPath [
                pkgs.acpi
                pkgs.libnotify
                pkgs.gnugrep
                pkgs.gawk
                pkgs.systemd
              ]}"
              acpi -b | grep "Battery 0" | awk -F'[,:%]' '{print $2, $3}' | {
                read -r status capacity
                battery_stat="$(acpi --battery | head -n 1)"
                if [ "$status" = Discharging -a "$capacity" -le 2 ]; then
                  notify-send -a "batMon" -u critical "Battery Critical: $capacity%\\n Hibernating"
                  sleep 5
                  systemctl hibernate
                elif [ "$status" = Discharging -a "$capacity" -le 5 ]; then
                  notify-send -a "batMon" -u critical "Battery Critical: $capacity%"
                elif [ "$status" = Discharging -a "$capacity" -le 20 ]; then
                  notify-send -a "batMon" -u critical "Battery Low: $capacity%"
                fi
              }
            '';
          in
          {
            ExecStart = "${batMon}";
          };
      };
    };
  };
}
