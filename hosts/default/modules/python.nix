{pkgs, ...}:

let

  python3 = pkgs.python3;
  python3Packages = python3.pkgs;

  #
    catppuccin_jupyterlab = python3Packages.buildPythonPackage rec {
      pname = "catppuccin_jupyterlab";
      version = "0.2.0";
      pyproject = true;

      src = python3Packages.fetchPypi {
        inherit pname version;
        hash = "sha256-DIaC5Z9S/30COQYDDZ3RxAcjwLtvo0YJk//OTDwQQUU=";
      };

      nativeBuildInputs = [
        python3Packages.setuptools
        python3Packages.wheel
        python3Packages.poetry-core
        python3Packages.poetry-dynamic-versioning
        python3Packages.hatchling
        python3Packages.jupyterlab
        python3Packages.hatch-jupyter-builder
        python3Packages.hatch-nodejs-version
      ];

      # has no tests
      doCheck = false;

    };

in

{

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
