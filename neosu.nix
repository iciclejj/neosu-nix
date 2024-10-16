{
  stdenv,
# autoPatchelfHook,
  curlFull,
  pkgconf,

  libbass,
  libbass_fx,
  libbassmix,
  libbassloud,
  util-linux,
  discord-rpc,
  freetype,
  glew,
  libGL,
  enet,
  libjpeg,
  xz,
  libXi,
  zlib,
  xorg,
}:

stdenv.mkDerivation {
  pname = "neosu";
  version = "5323268cab";

  src = fetchTarball {
    url = "https://git.kiwec.net/kiwec/McOsu/archive/5323268cab7c665223249823eab59fea08a443d0.tar.gz";
    sha256 = "0ar38kaqyfky3wdvjq8rcr2awl9my747knf97wbij4bsh1rd31c2";
  };

  patches = [ ./neosu.patch ./neosu-makefile.patch ];

  NIX_LDFLAGS = [
    "-lpthread"
    "-lGL"
    "-lcurl"
  ];

  nativeBuildInputs = [
      libbass
      libbass_fx
      libbassmix
      libbassloud
  ];

  buildInputs = [
    curlFull xorg.libX11 libbass libbass_fx libbassmix libbassloud discord-rpc
    libjpeg xz libXi zlib util-linux glew pkgconf xorg.libXdmcp enet freetype libGL
  ];

  configurePhase = ''
    mkdir -p $out
  '';

  installPhase = ''
    runHook preInstall
    mv ./build/* $out
    runHook postInstall
  '';

  enableParallelBuilding = true;
}
