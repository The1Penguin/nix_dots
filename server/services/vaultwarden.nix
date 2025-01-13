{ config, lib, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vault.acorneroftheweb.com";
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;

      ROCKET_LOG = "critical";
    };
  };

  services.nginx.virtualHosts."vault.acorneroftheweb.com" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
    };
  };
}
