{ stdenv, pkgs }:

rec {
  libbassloud = pkgs.callPackage ./libbassloud.nix { };
  neosu = pkgs.callPackage ./neosu.nix { inherit libbassloud; };
}
