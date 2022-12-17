{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "cpt-fetcher";
  version = "5414f55d8c406b2b632d4fd6b673b39f9ba2fb05";
  owner = "yzy-1";

  src = fetchFromGitHub {
    owner = owner;
    repo = pname;
    rev = version;
    sha256 = "sha256-Gt7Co0N2QUVd+8YauJx6iBD5EKG4OSDSk5qTCaWlqhQ=";
  };

  cargoSha256 = "sha256-xMR95njYz10pmvwa+Vy/70Z1UrBTuAwUiAY+dXrDoYY=";

  meta = with lib; {
    description = "A bridge between Competitive Companion and cpt.";
    homepage = "https://github.com/${owner}/${pname}";
    license = licenses.asl20;
  };
}
