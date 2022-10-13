{ lib, fetchFromGitHub, buildGoModule, ... }:

buildGoModule rec {
  pname = "cpt";
  version = "v0.16.3";
  owner = "cp-tools";

  src = fetchFromGitHub {
    owner = owner;
    repo = pname;
    rev = version;
    sha256 = "sha256-PgAnd0VbYr19Ml0HSXGas7pRR26Edwyyv5ngNiH3xVE=";
  };

  vendorSha256 = "sha256-2PdbP0mbQ13ShRPxSj26M0AXPX1mDrL0decxDcqwee4=";

  CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
  ];
  doCheck = false;

  meta = with lib; {
    description = "An amazing versatile CLI tool for competitive programming!";
    homepage = "https://github.com/${owner}/${pname}";
    license = licenses.gpl3;
  };
}
