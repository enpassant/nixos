with import <nixpkgs> {};
( let
  p110 = pkgs.python3.pkgs.buildPythonPackage rec {
      pname = "PyP100";
      version = "0.1.4";

      src = pkgs.fetchgit {
        url = "https://github.com/almottier/TapoP100.git";
        sha256 = "5YeRl7dbkv1RsWOcIdH67a/M1fjq9WXo4uTFiKLNys8=";
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
