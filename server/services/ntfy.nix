{ config, lib, pkgs, ... }:

{
  services.ntfy-sh = {
    enable = true;
    base-url = "https://ntfy.acorneroftheweb.com";
    settings = {
      auth-default-access = "deny-all";
      behind-proxy = true;
      attachment-total-size-limit = "150M";
      attachment-file-size-limit = "15M";
      attachment-expiry-duration = "12h";
    };
  };
}
