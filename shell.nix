{ pkgs ? import <nixpkgs> { } }:
with pkgs;

mkShell {
  buildInputs = [
    gitAndTools.pre-commit
    cacert
    niv
    dhall
    dhall-json
  ];
  shellHook = ''
  '';
}
