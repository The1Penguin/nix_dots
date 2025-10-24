{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    git-crypt
  ];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "pingu";
        email = "nor@acorneroftheweb.com";
      };
      pull.rebase = true;
      init.defaultBranch = "main";
      rerere.enabled = true;
    };
  };
  programs.difftastic = {
    enable = true;
    options.background = "light";
  };
}
