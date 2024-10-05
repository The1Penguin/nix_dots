{ config, lib, pkgs, ... }:

{
  programs = {
    fish = {
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
        fish_vi_key_bindings
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

    starship = {
      enable = true;
      settings = {
        format = "$nix_shell$character$directory";
        right_format = "$hostname";
        add_newline = false;

        hostname = {
          ssh_only = true;
          format = "[$hostname](bold yellow)";
        };

        directory = {
          truncation_length = 0;
          truncation_symbol = "…/";
          truncate_to_repo = false;
          read_only = " 🔒";
          style = "cyan";
        };
        character = {
          success_symbol = "[❯](bold purple)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
          vimcmd_replace_one_symbol = "[❯](bold blue)";
          vimcmd_replace_symbol = "[❯](bold blue)";
          vimcmd_visual_symbol = "[❮](bold yellow)";
        };
        nix_shell = {
          symbol = " ";
          format = "[$symbol$name]($style) ";
          style = "bright-purple bold";
          heuristic = true;
        };
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd cd" ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
