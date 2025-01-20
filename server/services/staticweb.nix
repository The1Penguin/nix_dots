{ config, lib, pkgs, ... }:

let init-website = {name, url, interval} : {
      systemd.services."init-${name}" = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        name = "init-${name}";
        serviceConfig.Type = "oneshot";
        script = ''
            cd /var/www
            rm ${name}
            ${pkgs.git}/bin/git clone --depth 1 --recursive --shallow-submodules ${url} ${name}
        '';
      };
    };
    update-website = {name, url, interval} : {
      systemd.timers."update-${name}" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "30s";
          OnUnitActiveSec = "${interval}s";
          Unit = "update-${name}.service";
        };
      };
      systemd.services."update-${name}" = {
        after = [ "init-${name}.service" ];
        name = "update-${name}";
        script = ''
            cd /var/www/${name}
            ${pkgs.git}/bin/git pull --recurse
        '';
      };
    };
in

# List of websites to host
builtins.listToAttrs (builtins.map (x: init-website x // update-website x) [
  {
    name = "homepage";
    url = "https://github.com/The1Penguin/Bento.git";
    interval = 3600;
  }
  {
    name = "website";
    url = "https://git.acorneroftheweb.com/pingu/blog.git";
    interval = 3600;
  } # Fix so it served on /public
]) //
{

}
