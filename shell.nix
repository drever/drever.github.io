let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.haskellPackages.hakyll
    pkgs.cabal-install
    pkgs.ghc
  ];
}
