{ pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [ 
    pkgs.beam.packages.erlangR24.erlang
  ] ;
 }


