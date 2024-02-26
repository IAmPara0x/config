{ pkgs, ... }:

let
  python3 = pkgs.python3;
  python3Packages = python3.pkgs;
  catppuccin_jupyterlab =
    pkgs.callPackage ../../../modules/catppuccin-jupyterlab.nix {
      buildPythonPackage = python3Packages.buildPythonPackage;
      fetchPypi = python3Packages.fetchPypi;
    };

in {

  home.packages = [
    (python3.withPackages (p: [
      python3
      python3Packages.pip
      python3Packages.jupyterlab
      python3Packages.regex
      python3Packages.requests
      python3Packages.numpy
      catppuccin_jupyterlab
    ]))

  ];
}
