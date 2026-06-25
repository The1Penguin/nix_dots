{ config, lib, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    monaspace
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.monofur
    nerd-fonts.zed-mono
    nerd-fonts.symbols-only
  ];
}
