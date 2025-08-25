{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    extraConfig = {
      modi = "drun";
      font = "DokiDokiMono Nerd Font 16";
      show-icons = false;
      fixed-num-lines = false;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = false;
      sorting-method = "fzf";
      matching = "fuzzy";
    };
    theme = "catppuccin-latte";
  };

  home.file = {
    ".local/share/rofi/themes".source = pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "rofi";
        rev = "5350da41a11814f950c3354f090b90d4674a95ce";
        hash = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
      } + "/basic/.local/share/rofi/themes";
  };

  catppuccin.rofi.enable = false;
}
