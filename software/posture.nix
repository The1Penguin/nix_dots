{ pkgs, ... }:

{
  systemd.user = {
    timers = {
      posture-check = {
        Unit.Description = "Remind to have better posture";
        Timer = {
          OnBootSec = "30min";
          OnUnitActiveSec = "30min";
          Unit = "posture-check.service";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
    services = {
      posture-check = {
        Unit.Description = "Remind to have better posture";
        Service =
          let
            posture = pkgs.writeShellScript "posture" ''
              ${pkgs.libnotify}/bin/notify-send -u critical "Remember to check your posture!"
            '';
          in
          {
            ExecStart = "${posture}";
          };
      };
    };
  };
}
