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
        )

        (deflayermap (base)
          caps @ectl
        )
      '';
    };
  };
}
