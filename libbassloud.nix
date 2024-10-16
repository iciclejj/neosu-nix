{ lib, stdenv, unzip, fetchurl }:

let
  bassloud = {
    h = "bassloud.h";
    version = "2.4.17";
    so = {
      i686_linux = "libs/x86/libbassloud.so";
      x86_64-linux = "libs/x86_64/libbassloud.so";
      armv7l-linux = "libs/armhf/libbassloud.so";
      aarch64-linux = "libs/aarch64/libbassloud.so";
    };
    url = "https://web.archive.org/web/20240501180538/http://www.un4seen.com/files/bassloud24-linux.zip";
    hash = "sha256-nm02yR8ecIaNZ6KfLa20AyfOFqhM4icKZgmGJSUfPlE=";
  };

  # from nixpkgs/pkgs/development/libraries/audio/libbass/default.nix
  dropBass = name: bass: stdenv.mkDerivation {
    pname = "lib${name}";
    inherit (bass) version;

    src = fetchurl {
      inherit (bass) hash url;
    };

    unpackCmd = ''
      mkdir out
      ${unzip}/bin/unzip $curSrc -d out
    '';

    lpropagatedBuildInputs = [ unzip ];
    dontBuild = true;
    installPhase =
      let so =
            if bass.so ? ${stdenv.hostPlatform.system} then bass.so.${stdenv.hostPlatform.system}
            else throw "${name} not packaged for ${stdenv.hostPlatform.system} (yet).";
      in ''
        mkdir -p $out/{lib,include}
        install -m644 -t $out/lib/ ${so}
        # install -m644 -t $out/include/ ${bass.h} # bassloud24 doesn't include this for some reason
      '';

    meta = with lib; {
      description = "Shareware audio library";
      homepage = "https://www.un4seen.com/";
      license = licenses.unfreeRedistributable;
      platforms = builtins.attrNames bass.so;
      maintainers = with maintainers; [ jacekpoz ];
    };
  };
in
dropBass "libbassloud" bassloud
