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
    export OC='../package.dhall sha256:10959fd740e42d3feab0d302d4e9d31da31afbb0f040c7f4ff190ccf4e80d59e'
    export ARGO='../package.dhall sha256:d214b82fb74db8abbbdcebb3046bc4899515e5ac71657e6f7d11db313c34888a'
  '';
}
