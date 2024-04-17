{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ":q" = "exit";
      "q" = "exit";
      "vim" = "nvim";
      "emacs" = "emacsclient -nw -c -a \"\"";
      "ls" = "eza --icons --group-directories-first";
      "ll" = "eza -alF --icons --group-directories-first";
      "b" = "bluetoothctl";
    };

    shellInit = ''
      if command -q sk
          skim_key_bindings
      end
      set fish_greeting
      export MANPAGER="bat -p"
      export PAGER="bat"
      export BAT_THEME="Catppuccin-latte"
    '';

    interactiveShellInit = ''
      any-nix-shell fish --info-right | source
    '';

    plugins = [
      {
        name = "sudope";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-sudope";
          rev = "83919a692bc1194aa322f3627c859fecace5f496";
          sha256 = "sha256-pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
        };
      }
    ];
  };
}
