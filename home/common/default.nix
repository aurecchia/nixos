{ ... }:
{
  imports = [
    # You can also split up your configuration and import pieces of it here:
    ./wm
    ./cli
    ./rofi
    ./kitty
    ./git
    ./firefox.nix
    ./nvim
    ./tmux.nix
    ./jetbrains.nix
    ./gcloud.nix
    ./citrix
    # ./httpie/httpie-oauth2-client-credentials.nix
  ];
}
