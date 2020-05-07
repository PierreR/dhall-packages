{ pkgs ? import <nixpkgs> { } }:
with pkgs;

mkShell {
  buildInputs = [
    asciidoctor
    gitAndTools.pre-commit
    cacert
    niv
    unstable.dhall
    unstable.dhall-json
  ];
  shellHook = ''
  '';
}
