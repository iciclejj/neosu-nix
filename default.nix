let
  pkgs = import <nixpkgs> { };
in
rec {
  libbassloud = pkgs.callPackage ./libbassloud.nix { };
  neosu = pkgs.callPackage ./neosu.nix { inherit libbassloud; };
}
