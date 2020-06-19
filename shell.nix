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
    export OC='../package.dhall sha256:0883c568eb58c94a29e6c561d4cfa218d80687840363289608067c1637bbd9bb'
    export ARGO='../package.dhall sha256:d214b82fb74db8abbbdcebb3046bc4899515e5ac71657e6f7d11db313c34888a'
  '';
}
