{ lib, buildPythonPackage, fetchPypi, httpie, ... }:

buildPythonPackage rec {
  pname = "httpie-httpie-oauth2-client-credentials";
  version = "0.2.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "6711a04fff0a38ef7fed90bb37d6c09096b09efcb4b95e12f1c05aa883bba146";
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
