let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = [
    # Haskell Toolchain
    pkgs.ghc
    pkgs.cabal-install
    
    # Hakyll (optional hier, wenn du es via Cabal baust, 
    # aber nützlich für die globale Verfügbarkeit)
    pkgs.haskellPackages.hakyll 

    # C-Abhängigkeiten und Build-Tools für Cabal
    pkgs.zlib
    pkgs.pkg-config
  ];
}
