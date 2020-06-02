{ pkgs ? import <nixpkgs> { } }:
with pkgs;

mkShell {
  buildInputs = [
    gitAndTools.pre-commit
    cacert
    dhall
    dhall-json
    fd
  ];
  shellHook = ''
  '';
}
