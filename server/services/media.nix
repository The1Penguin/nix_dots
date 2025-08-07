{ config, lib, pkgs, secrets, ... }:

{
  services = {
    flaresolverr.enable = true;
    prowlarr.enable = true;
    radarr = {
      enable = true;
      group = "media";
      user = "media";
    };
    sonarr = {
      enable = true;
      group = "media";
      user = "media";
    };
    lidarr = {
      enable = true;
      group = "media";
      user = "media";
    };
    audiobookshelf = {
      enable = true;
      port = 8000;
      host = "0.0.0.0";
      openFirewall = true;
      group = "media";
      user = "media";
      dataDir = "/media/completed";
    };
    calibre-web = {
      enable = true;
      user = "media";
      group = "media";
      options.enableBookUploading = true;
      reverseProxyAuth.enable = true;
      calibreLibrary = "/media/completed/books";
    };
    jellyfin = {
      enable = true;
      user = "media";
      group = "media";
    };
    navidrome = {
      enable = true;
      user = "media";
      group = "media";
      environmentFile = pkgs.writeText "envFile" ''
        ND_MUSICFOLDER=/media/completed/books
        ND_LASTFM_APIKEY=${secrets.navidrome.lastfm_key}
        ND_LASTFM_SECRET=${secrets.navidrome.lastfm_secret}
        ND_LISTENBRAINZ_BASEURL=https://maloja.acorneroftheweb.com/apis/listenbrainz/1/
        ND_ENABLESHARING=true
      '';
    };
    # TODO: Add maloja here somehow. I might have to package it myself ^_^"
    qbittorrent = {
      enable = true;
      user = "media";
      group = "media";
    };
    slskd = {
      enable = true;
      user = "media";
      group = "media";
      settings = {
        authentication = {
          username = secrets.slskd.username;
          password = secrets.slskd.password;
        };
        directories = {
          incomplete = "/media/incomplete";
          downloads = "/media/completed/music";
        };
        soulseek = {
          address = "vps.slsknet.org";
          port = 2271;
          username = secrets.soulseek.username;
          password = secrets.soulseek.password;
        };
      };
    };
  };

  systemd.services.qbittorrent = config.services.namespaced-wg.systemdMods;
  systemd.services.slskd = config.services.namespaced-wg.systemdMods;
}
