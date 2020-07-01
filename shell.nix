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
    export OC='../package.dhall sha256:5c0bd30ac3c1d0914770754fe82256720a04471f38a26bbc6b63bd7ebd9eea94'
  '';
}
