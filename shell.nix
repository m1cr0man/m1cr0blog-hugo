{ pkgs ? import (builtins.getFlake "nixpkgs") { } }:
with pkgs;
mkShell {
  buildInputs = [
    hugo
  ];
}
