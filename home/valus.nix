# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  nix-colors,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./i3
    ./cli.nix
    ./rofi
    ./kitty
    ./git
    ./firefox.nix
    ./nvim
    ./zsh.nix
    ./jetbrains.nix
    ./gcloud.nix
  ];

  fonts.fontconfig.enable = true;

  home.file = {
    ".Xresources".source = ./Xresources;
  };

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    inter
    dconf
    xclip
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_8_0
    ])
    inkscape
    slack
    spotify
    zathura
    telegram-desktop
    discord
    wine
    docker-credential-helpers
    # m8c-stable
  ];

  programs.password-store = {
    enable = true;
  };

  # programs.gpg = {
  #   enable = true;
  # };

#   programs.redshift = {
#     enable = true;
#     location = {
#       provider = "manual";
#       latitude = "47.3595";
#       longitue = "8.6356";
#     };
#   };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "auri";
    homeDirectory = "/home/auri";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
