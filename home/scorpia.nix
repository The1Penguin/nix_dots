args@{ config, lib, pkgs, ... }:

let
  username = "pingu";
  homeDir = "/home/${username}";
in
{

  imports = [
    software/alacritty.nix
    software/audio.nix
    software/bat.nix
    software/battery.nix
    software/bitwarden.nix
    software/catppuccin.nix
    software/communication.nix
    software/cursor.nix
    software/emacs.nix
    software/fish.nix
    software/foot.nix
    software/games.nix
    software/gammastep.nix
    software/git.nix
    software/gtk.nix
    (import software/home.nix (args // { username = username; homeDir = homeDir; }))
    software/home-manager.nix
    software/hydration.nix
    software/hyfetch.nix
    software/kanshi.nix
    software/keyring.nix
    software/languages.nix
    software/latex.nix
    software/librewolf.nix
    software/mpv.nix
    software/music.nix
    software/neovim.nix
    software/niri.nix
    software/nix.nix
    software/nmapplet.nix
    software/playerctl.nix
    software/pomodoro.nix
    software/posture.nix
    software/powertop.nix
    software/presentation.nix
    software/qt.nix
    software/qview.nix
    software/rdp.nix
    software/river.nix
    software/spotify.nix
    (import software/syncthing.nix (args // { homeDir = homeDir; }))
    software/tailscale.nix
    software/thunar.nix
    software/tkey.nix
    software/wireplumber.nix
    software/yazi.nix
    software/zathura.nix
    software/zellij.nix
    software/zsa.nix
  ];
}
