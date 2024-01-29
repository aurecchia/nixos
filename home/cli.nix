{ pkgs, ... }:

{
  home.packages = with pkgs; [
    delta
    fd
    fzf
    postgresql
    ripgrep
    zip
    hyperfine
  ];

  programs = {
    jq.enable = true;
    pandoc.enable = true;
  };
}
