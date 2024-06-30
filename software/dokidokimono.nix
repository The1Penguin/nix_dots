{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "doki-doki-mono";

  src = ./Doki-Doki-Mono.zip;

  patcher = (pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FontPatcher.zip";
    sha256 = "sha256-ZJpF/Q5lfcW3srb2NbJk+/QEuwaFjdzboa+rl9L7GGE=";
    stripRoot = false;
  });

  nativeBuildInputs = [ pkgs.fontforge (pkgs.python3.withPackages (p: [ p.fontforge ])) ];

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    python3 -OO $patcher/font-patcher --complete --careful --custom ${pkgs.fira-code-symbols}/share/fonts/opentype/FiraCode-Regular-Symbol.otf -out $out/share/fonts/opentype Doki\ Doki\ Mono/DokiDokiMono-Regular.otf
    python3 -OO $patcher/font-patcher --complete --careful --custom ${pkgs.fira-code-symbols}/share/fonts/opentype/FiraCode-Regular-Symbol.otf -out $out/share/fonts/opentype Doki\ Doki\ Mono/DokiDokiMono-Italic.otf

    runHook postInstall
  '';
}
