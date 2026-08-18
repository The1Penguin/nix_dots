{ pkgs, ... }:

pkgs.writeScriptBin "mylock" ''
  ${pkgs.swaylock}/bin/swaylock \
      -i ${pkgs.wall} \
      -f \
      --indicator-radius 100 \
      --indicator-thickness 7 \
      --ring-color bb00cc \
      --key-hl-color 40a02b \
      --line-color 00000000 \
      --inside-color e6e9ef \
      --separator-color 40a02b \
      --ring-color 00000000 \
      --text-color 4c4f69 \
      --text-ver-color 4c4f69 \
      --inside-ver-color e6e9ef \
      --inside-wrong-color e6e9ef \
      --ring-ver-color 00000000 \
      --ring-wrong-color 00000000 \
      --line-ver-color 00000000 \
      --line-wrong-color 00000000
''
