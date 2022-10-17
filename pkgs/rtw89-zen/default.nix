{ pkgs, lib, stdenv, fetchFromGitHub, ... }:
with pkgs.legacyPackages.x86_64-linux;
let kernel = pkgs.linuxKernel.packages.linux_zen.kernel;
  modDestDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtw89";
in
stdenv.mkDerivation rec {
  pname = "rtw89-zen";
  version = "f11fadeab69a1e747318b1d7fd2ad58fa9518ab1";
  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtw89";
    rev = version;
    sha256 = "sha256-t9Upwopuq+BuMHoHjIAny7gvtm6RZqL3EHVx9cu++9k=";
  };
  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies ++ (with pkgs; [ openssl mokutil ]);
  makeFlags = kernel.makeFlags ++ [
    "KVER=${kernel.modDirVersion}"
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];
  installPhase = ''
    runHook preInstall
    mkdir -p ${modDestDir}
    find . -name '*.ko' -exec cp --parents {} ${modDestDir} \;
    find ${modDestDir} -name '*.ko' -exec xz -f {} \;
    runHook postInstall
  '';
}
