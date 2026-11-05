{
  config,
  lib,
  pkgs,
  ...
}:

let
  devCertTrustDir = "${config.home.homeDirectory}/.aspnet/dev-certs/trust";
  sslCertDir = "${devCertTrustDir}:/etc/ssl/certs";
  certTools = with pkgs; [
    openssl
    nssTools
  ];
  dotnet = pkgs.dotnet-sdk_10;
in {
  home.packages = certTools;

  # OpenSSL (.NET HttpClient) reads extra CAs from here on Linux.
  home.sessionVariables = {
    SSL_CERT_DIR = sslCertDir;
  };

  home.activation.aspNetDevCert = lib.hm.dag.entryAfter ["writeBoundary"] ''
    export SSL_CERT_DIR="${sslCertDir}"
    export PATH="${lib.makeBinPath certTools}:$PATH"
    if ! ${lib.getExe dotnet} dev-certs https --check --trust --quiet 2>/dev/null; then
      run ${lib.getExe dotnet} dev-certs https --trust --quiet
    fi
  '';
}
