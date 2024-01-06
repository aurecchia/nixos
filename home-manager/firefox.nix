{ inputs, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.auri = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [ ublock-origin bitwarden ];
    };
  };
}
