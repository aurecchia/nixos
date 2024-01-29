{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable.jetbrains; [
    rider
  ];
}
