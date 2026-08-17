{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "sakuraflower.png";
  src = ./..;
  phases = [ "installPhase" ];
  installPhase = ''
    cp $src/sakuraflower.png $out
  '';
}
