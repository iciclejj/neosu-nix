{
clang-tools,
  stdenv,
  fetchzip,
  autoPatchelfHook,
  curlFull,
  pkgconf,

  libbass,
  libbass_fx,
  libbassmix,
  libbassloud,
  util-linux, #blkid
  discord-rpc,
  freetype,
#ftgl,
  glew,
  libGL,
  glxinfo,
  enet,
  libjpeg,
  xz,
  libXi,
  zlib,
  xorg,
}:

stdenv.mkDerivation {
  pname = "neosu";
  version = "master";

  src = fetchTarball {
    url = "https://git.kiwec.net/kiwec/McOsu/archive/master.tar.gz";
    sha256 = "0ar38kaqyfky3wdvjq8rcr2awl9my747knf97wbij4bsh1rd31c2";
  };

  patches = [ ./neosu.patch ./neosu-no-sanitize.patch ];

  #nativeBuildInputs = [ clang-tools ];
  NIX_LDFLAGS = [
    "-lpthread"
    "-lGL"
    "-lcurl"
    # " -V"
  ];


  buildInputs = [
    curlFull xorg.libX11 libbass libbass_fx libbassmix libbassloud discord-rpc
    libjpeg xz libXi zlib util-linux glew pkgconf xorg.libXdmcp enet freetype libGL
  ];

  installPhase = ''
    cp -r build $out
  '';


  enableParallelBuilding = true;
}
