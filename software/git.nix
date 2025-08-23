{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    git-crypt
  ];
  programs.git = {
    enable = true;
    userName = "pingu";
    userEmail = "nor@acorneroftheweb.com";
    difftastic = {
      enable = true;
      background = "light";
    };
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      rerere.enabled = true;
    };
  };
}
