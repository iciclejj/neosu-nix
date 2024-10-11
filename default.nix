let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
rec {
  #stdenv = pkgs.llvmPackages.libcxxStdenv;
  #stdenv = pkgs.gcc10Stdenv;

  libbassloud = pkgs.callPackage ./libbassloud.nix { };
  neosu = pkgs.callPackage ./neosu.nix { inherit libbassloud;};
}
