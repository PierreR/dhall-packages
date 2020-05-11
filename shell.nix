{ pkgs ? import <nixpkgs> { } }:
with pkgs;

mkShell {
  buildInputs = [
    asciidoctor
    gitAndTools.pre-commit
    cacert
    niv
    dhall
    dhall-json
  ];
  shellHook = ''
  '';
}
