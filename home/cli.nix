{ pkgs, ... }:

{
  home.packages = with pkgs; [
    delta
    fd
    fzf
    postgresql
    ripgrep
    zip
  ];

  programs = {
    jq.enable = true;
    pandoc.enable = true;
  };
}
