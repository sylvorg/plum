with import <nixpkgs> { };
with lib;
let
  beartype = python311Packages.beartype.overrideAttrs (old: {
    src = fetchFromGitHub {
      owner = "beartype";
      repo = "beartype";
      rev = "75e64bc857d26a2e59e4d4743cedd66d2f68a5d4";
      sha256 = "sha256-8fs+j10bj/vU+l+SeFu+YkPajHeD3q3QFWMchXxjBHk=";
    };
  });
  plum-dispatch = 
    { hatchling, hatch-vcs, buildPythonPackage, typing-extensions
    , rich, fetchPypi }:
    buildPythonPackage rec {
      pname = "plum_dispatch";
      version = "2.3.2";
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-9J8A3996sPFsm4XMJ8xSQf+1mu4CIYusZx7Hwaxl4Tk=";
      };
      format = "pyproject";
      propagatedBuildInputs = [ beartype typing-extensions rich ];
      propagatedNativeBuildInputs = propagatedBuildInputs;
      buildInputs = [ hatchling hatch-vcs ];
      nativeBuildInputs = buildInputs;
      meta = {
        description = "Multiple dispatch in Python";
        homepage = "https://beartype.github.io/plum/intro.html";
        license = licenses.mit;
      };
    };
  plum-off = { buildPythonPackage, fetchFromGitHub, more-itertools
    , poetry-core, pytest, rich }:
    buildPythonPackage rec {
      pname = "plum_off";
      version = "1.0.0.0";
      src = ./.;
      format = "pyproject";
      nativeBuildInputs = toList poetry-core;
      propagatedNativeBuildInputs = [
        beartype
        (python311Packages.callPackage plum-dispatch { })
        rich
      ];
    };
in mkShell { buildInputs = toList (python311Packages.callPackage plum-off { }); }
