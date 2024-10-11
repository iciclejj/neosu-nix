{
  stdenv, autoPatchelfHook, libbass
}:
stdenv.mkDerivation {
  name = "libbassloud";
  src = ./.;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    libbass
  ];

  installPhase = ''
    runHook preInstall
    install -D libbassloud.so $out/lib/libbassloud.so
    runHook postInstall
  '';
}
