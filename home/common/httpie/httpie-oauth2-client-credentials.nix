{ lib, buildPythonPackage, fetchPypi, httpie, ... }:

buildPythonPackage rec {
  pname = "httpie-oauth2-client-credentials";
  version = "0.2.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "e35fc2b1c379f71c5e62112f9e0e77862c13ff74b1b5bd2350cd0bcb53c9eaa7";
  };

  # propagatedBuildInputs = [ httpie requests_ntlm ];
  propagatedBuildInputs = [ httpie ];

  # Package have no tests
  doCheck = false;

  # pythonImportsCheck = [ "httpie_ntlm" ];

  meta = with lib; {
    description = "OAuth2.0 Client Credentials auth plugin for HTTPie";
    homepage = "https://github.com/satodoc/httpie-oauth2-client-credentials";
    license = licenses.mit;
    maintainers = with maintainers; [ aurecchia ];
  };
}
