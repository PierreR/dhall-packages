let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in pkgs.mkShell {
  name = "index-metadata";
  buildInputs = [
    pkgs.gitAndTools.pre-commit
    pkgs.cacert
    pkgs.niv
    pkgs.dhall-json
    pkgs.dhall
  ];
  shellHook = ''
  '';
}
