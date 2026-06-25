{ config, lib, pkgs, homeDir, secrets, ... }:

{
  services.syncthing = {
    enable = true;
    settings = {
      devices.catra = {
        addresses = [ "tcp://sync.acorneroftheweb.com" ];
        id = secrets.syncthing.catra;
      };
      devices.entrapta = {
        addresses = [ "dynamic" ];
        id = secrets.syncthing.entrapta;
      };
      devices.scorpia = {
        addresses = [ "dynamic" ];
        id = secrets.syncthing.scorpia;
      };
      devices.glimmer = {
        addresses = [ "dynamic" ];
        id = secrets.syncthing.glimmer;
      };
      folders.Main = {
        path = "${homeDir}/.syncthing";
        devices = [ "catra" "entrapta" "scorpia" ];
        versioning = {
          type = "simple";
          params.keep = "5";
          params.cleanoutDays = "15";
        };
      };
      folders.Pictures = {
        path = "${homeDir}/pic";
        devices = [ "catra" "entrapta" "scorpia" "glimmer" ];
        versioning = {
          type = "simple";
          params.keep = "5";
          params.cleanoutDays = "15";
        };
      };
      folders."Phone Pics" = {
        path = "${homeDir}/ppics";
        devices = [ "catra" "entrapta" "scorpia" "glimmer" ];
      };
      options.localAnnounceEnabled = false;
      options.urAccepted = -1;
    };
  };
}
