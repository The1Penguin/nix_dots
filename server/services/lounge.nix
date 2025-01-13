{ config, lib, pkgs, ... }:

{
  services.thelounge = {
    enable = true;
    port = 9000;
    public = false;
    plugins = [

    ];
    extraConfig = {
      reverseProxy = true;
      maxHistory = 10000;
      https.enable = false; # Reverse proxy enabled
      prefetch = true;
      prefetchStorage = false;
      prefetchMaxImageSize = 50000;
      prefetchMaxSearchSize = 900;
      fileUpload = {
        enable = true;
        maxFileSize = 50000;
      };
      transports = [ "websockets" ];
      defaults = {
        name = "Dtek.se";
        host = "irc.dtek.se";
        port = 6697;
        password = "";
        tls = true;
        rejectUnauthorized = false;
        nick = "anna";
        username = "";
        realname = "";
        join = "#dtek";
        leaveMessage = "";
      };
    };
  };
}
