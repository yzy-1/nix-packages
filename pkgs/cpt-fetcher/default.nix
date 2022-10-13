{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "cpt-fetcher";
  version = "c135993c585ff790de36a4cf54cd11135daca114";
  owner = "yzy-1";

  src = fetchFromGitHub {
    owner = owner;
    repo = pname;
    rev = version;
    sha256 = "sha256-491/Y0Eo4K/24XyOVygUI9Y4pOP8lKfXndV8yFbZ4tw=";
  };

  cargoSha256 = "sha256-Pn8psTMOq2vLQafBEDwoio/OPNobWnAhj2mGu9qncac=";

  meta = with lib; {
    description = "A bridge between Competitive Companion and cpt.";
    homepage = "https://github.com/${owner}/${pname}";
    license = licenses.asl20;
  };
}
