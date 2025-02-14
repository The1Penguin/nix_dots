{ config, lib, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
    return {
           font = wezterm.font("DokiDokiMono Nerd Font"),
           font_size = 16.0,
           audible_bell = "Disabled",
           window_background_opacity = 0.93,
           enable_wayland = true,
           enable_tab_bar = false,
           color_scheme = "Catppuccin Latte",
           window_padding = {
                           left = 5,
                           right = 5,
                           top = 3,
                           bottom = 3,
           },
    }
    '';
 };
}
