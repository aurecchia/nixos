{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    delta
    fd
    fzf
    postgresql
    ripgrep
    zip
    hyperfine
    gh
  ];

  programs = {
    jq.enable = true;
    pandoc.enable = true;
  };
}
