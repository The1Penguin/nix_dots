{ config, lib, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      vo = "gpu";
      hwdec = "vaapi";
      gpu-context = "wayland";
      slang = "en,eng";
      alang = "ja,jp,jpn,en,eng";
      image-display-duration = "inf";
      cache = "yes";
      keepaspect-window = "yes";
    };
    bindings = {
      "l" = "seek 5";
      "h" = "seek -5";
      "a" = "add chapter -1";
      "d" = "add chapter 1";
      "k" = "seek 60";
      "j" = "seek -60";
      "e" = "add speed 0.1";
      "r" = "add speed -0.1";
      "w" = "cycle-values speed 1 1.5 2";
      "shift+s" = "async screenshot";
    };
  };
}
