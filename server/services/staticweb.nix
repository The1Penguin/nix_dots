{ config, lib, pkgs, ... }:

let update-website = {name, url, interval} : {
    systemd.services."update-${name}" = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      name = "update-${name}";
      script = ''
          cd /var/www
          ${pkgs.git}/bin/git clone --depth 1 --recursive --shallow-submodules ${url} ${name}
          cd ${name}
          while true
          do
            git pull --recurse
            sleep ${interval}
          done
      '';
    };
  }; in

# List of websites to host
builtins.listToAttrs (builtins.map update-website [
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
