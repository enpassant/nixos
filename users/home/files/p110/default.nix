with import <nixpkgs> {};
( let
  p110 = pkgs.python3.pkgs.buildPythonPackage rec {
      pname = "PyP100";
      version = "0.1.4";

      src = pkgs.fetchgit {
        url = "https://github.com/almottier/TapoP100.git";
        sha256 = "lEoRDViiLYB/Rl3upqSSpFe2G2zXH4Z4oqW4sO9npb4=";
      };

      doCheck = false;

      meta = {
        homepage = "git+https://github.com/almottier/TapoP100.git@main";
        description = "P110";
      };
    };
  in python3.withPackages (ps: [
    ps.requests ps.pycrypto p110
  ])
  ).env
