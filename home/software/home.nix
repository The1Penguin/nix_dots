{ config, lib, pkgs, username, homeDir, ... }:

{

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "23.05";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;
    desktop = "${homeDir}";
    documents = "${homeDir}/doc";
    download = "${homeDir}/dwn";
    music = "${homeDir}/msc";
    pictures = "${homeDir}/pic";
    publicShare = "${homeDir}/srv";
    templates = "${homeDir}/doc/templates";
    videos = "${homeDir}/vid";
  };
}
