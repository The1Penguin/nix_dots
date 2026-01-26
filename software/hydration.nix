{ pkgs, ... }:

{
  systemd.user = {
    timers = {
      hydration-check = {
        Unit.Description = "Remind to hydrate";
        Timer = {
          OnBootSec = "1hour";
          OnUnitActiveSec = "1hour";
          Unit = "hydration-check.service";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
    services = {
      hydration-check = {
        Unit.Description = "Remind to hydrate";
        Service =
          let
            hydration = pkgs.writeShellScript "hydration" ''
              ${pkgs.libnotify}/bin/notify-send -a "hydration" -u low "Remember to hydrate!"
            '';
          in
          {
            ExecStart = "${hydration}";
          };
      };
    };
  };
}
