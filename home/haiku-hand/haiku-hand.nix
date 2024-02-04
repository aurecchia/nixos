{ stdenv }:
stdenv.mkDerivation rec {
  name = "haiku-hand-${version}";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/share/icons/
    tar xjf ./HaikuHand.tar.bz2 -C $out/share/icons/
  '';
}

