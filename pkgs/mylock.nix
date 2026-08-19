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
      --inside-color e6e9efee \
      --inside-ver-color e6e9efee \
      --inside-wrong-color e6e9efee \
      --inside-clear-color e6e9efee \
      --separator-color 40a02b \
      --ring-color 00000000 \
      --ring-clear-color 00000000 \
      --text-color 4c4f69 \
      --text-ver-color 4c4f69 \
      --text-clear-color 4c4f69 \
      --ring-ver-color 00000000 \
      --ring-wrong-color 00000000 \
      --ring-clear-color 00000000 \
      --line-ver-color 00000000 \
      --line-wrong-color 00000000 \
      --line-clear-color 00000000
''
