{ pkgs, ... }:
{
  home.packages = [
    (pkgs.citrix_workspace.override {
      extraCerts = [ ./SectigoRSADomainValidationSecureServerCA.crt ];
    })
  ];
}

