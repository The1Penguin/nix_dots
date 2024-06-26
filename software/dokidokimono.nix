{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "doki-doki-mono";

  src = ./Doki-Doki-Mono.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 Doki\ Doki\ Mono/*.otf -t $out/share/fonts/opentype

    runHook postInstall
  '';
}
