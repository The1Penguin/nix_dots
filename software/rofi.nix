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
        owner = "The1Penguin";
        repo = "catpuccin-rofi";
        rev = "78c7f8f2bffe3f1cf89b658543b8264162af5217";
        hash = "sha256-oUIbbcHYdSjGruS36NDr2KZgsktwv4lJU5Qo//H1cWw=";
      } + "/basic/.local/share/rofi/themes";
  };

  catppuccin.rofi.enable = false;
}
