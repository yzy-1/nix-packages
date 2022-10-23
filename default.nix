# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  cpt-fetcher = pkgs.callPackage ./pkgs/cpt-fetcher { };
  cpt = pkgs.callPackage ./pkgs/cpt { };
  rtw89-zen = pkgs.callPackage ./pkgs/rtw89-zen { };
  v2raya = pkgs.callPackage ./pkgs/v2raya { v2ray = (import (builtins.getFlake "github:NixOS/nixpkgs/908245b5532e4fcfedc8e6f15abc330ad5942506") {}).v2ray; };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
