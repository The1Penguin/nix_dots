{ config, lib, pkgs, ... }:

{
  services.kanata = {
    enable = true;
    package = pkgs.kanata-with-cmd;
    keyboards.main = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defvar
          tap-time 150
          hold-time 150)

        (deflocalkeys-linux
          §   41
          +   12
          ´   13 ;; Acute accent. Opposite to the grave accent (grv).
          å   26
          ¨   27
          ö   39
          ä   40
          '   43
          <   86
          ,   51
          .   52
          -   53
        )

        (defsrc
          §    1    2    3    4    5    6    7    8    9    0    +    ´    bspc
          tab  q    w    e    r    t    y    u    i    o    p    å    ¨
          caps a    s    d    f    g    h    j    k    l    ö    ä    '    ret
          lsft <    z    x    c    v    b    n    m    ,    .    -         rsft
          lctl lmet lalt                spc                 ralt rmet menu rctl
        )

        (defalias
          ectl (tap-hold $tap-time $hold-time esc lctrl)
          ö    (tap-hold $tap-time $hold-time <    ö)
          ä    (tap-hold $tap-time $hold-time S-<  ä)
          å    (tap-hold $tap-time $hold-time RA-< å)
          ¨    (tap-hold $tap-time $hold-time S-.  S-,)
          a    (tap-hold $tap-time $hold-time a    S-8)
          s    (tap-hold $tap-time $hold-time s    S-9)
          q    (tap-hold $tap-time $hold-time q    RA-7)
          w    (tap-hold $tap-time $hold-time w    RA-8)
          e    (tap-hold $tap-time $hold-time e    RA-9)
          r    (tap-hold $tap-time $hold-time r    RA-0)
          base (tap-hold $tap-time $hold-time ´    (layer-switch base))
          prog (tap-hold $tap-time $hold-time ´    (layer-switch prog))

        )


        (deflayermap (base)
          caps @ectl
          ´ @prog
        )

        (deflayermap (prog)
          caps @ectl
          a @a
          s @s
          q @q
          w @w
          e @e
          r @r
          ö @ö
          ä @ä
          å @å
          ¨ @¨
          ´ @base
        )

      '';
    };
  };
}
