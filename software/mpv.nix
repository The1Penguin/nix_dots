{ config, lib, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      osc = "no";
      osd-bar = "no";
      profile = "gpu-hq";
      vo = "gpu";
      loop-file = "inf";
      hwdec = "vaapi";
      gpu-context = "wayland";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      save-position-on-quit = "yes";
      video-sync = "display-resample";
      interpolation = "yes";
      tscale = "oversample";
      slang = "en,eng";
      alang = "ja,jp,jpn,en,eng";
      image-display-duration = "inf";
      cache = "yes";
      demuxer-max-bytes = "650MiB";
      demuxer-max-back-bytes = "50MiB";
      demuxer-readahead-secs = "60";
      border = "no";
      keepaspect-window = "yes";
      deband = true;
      deband-grain = 0;
      deband-range = 12;
      deband-threshold = 32;
      dither-depth = "auto";
      dither = "fruit";
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
      "g" = "script-binding memo-history";
      "tab" = "script-binding uosc/toggle-ui";
      "c" = "script-binding uosc/chapters";
      "q" = "script-binding uosc/stream-quality";
      "t" = "script-binding uosc/audio";
      "shift+f" = "script-binding uosc/keybinds";
      "shift+p" = "script-binding uosc/items";
      "s" = "script-binding uosc/subtitles";
      "u" = "script-message-to youtube_upnext menu";
      "shift+s" = "async screenshot";
    };
    scripts = with pkgs.mpvScripts; [
      autoload
      mpv-cheatsheet
      youtube-upnext
      memo
      reload
      uosc
      thumbfast
      sponsorblock
    ];
  };

}
