{ config, lib, pkgs, ... }:

let
  website = { name, url, interval, subpath, domain }: {
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
    services.nginx.virtualHosts."${domain}" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/${name}/${subpath}";
    };
  };
in

# List of websites to host
builtins.listToAttrs
  (builtins.map website [
    {
      name = "homepage";
      url = "https://github.com/The1Penguin/Bento.git";
      interval = 666;
      subpath = "/";
      domain = "homepage.acorneroftheweb.com";
    }
    {
      name = "website";
      url = "https://git.acorneroftheweb.com/pingu/blog.git";
      interval = 666;
      subpath = "/public";
      domain = "acorneroftheweb.com";
    }
])
