{ mkDerivation, base, shelly, stdenv, text }:
mkDerivation {
  pname = "hub2hub";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base shelly text ];
  license = stdenv.lib.licenses.bsd3;
}
