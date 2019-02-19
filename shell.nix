with import <nixpkgs> {};

let
  # hub2hub = haskellPackages.callPackage ./release.nix {};
in
stdenv.mkDerivation {
  name = "hub2hub-shell";
  buildInputs = [ cabal2nix ghc cabal-install ];
}
