# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  nix-colors,
  ...
}: 
let 
  haiku-hand = (pkgs.callPackage ./common/haiku-hand/haiku-hand.nix {});
  # httpie-oauth2-client-credentials = (pkgs.callPackage ./common/httpie/httpie-oauth2-client-credentials.nix {
  #   buildPythonPackage = pkgs.python3Packages.buildPythonPackage;
  # });
  # httpie = (pkgs.callPackage ./common/httpie/default.nix { 
  #   buildPythonApplication = pkgs.python3Packages.buildPythonApplication;
  #   httpie-oauth2-client-credentials = httpie-oauth2-client-credentials;
  #   pythonPackages = pkgs.hpython3Packages;
  #   pandoc = pkgs.pandoc;
  # });
in {
  # You can import other home-manager modules here
  imports = [
    ./common
  ];

  fonts.fontconfig.enable = true;

  # home.file = {
  #   ".Xresources".source = ./Xresources;
  # };

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    inter
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    dconf
    xclip
    hsetroot

    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_8_0
    ])

    nodePackages.vim-language-server
    difftastic

    gimp-with-plugins
    inkscape
    simplescreenrecorder
    mate.mate-utils

    slack
    vlc
    mpv
    spotify
    zathura
    telegram-desktop
    discord
    wine
    docker-credential-helpers
    # m8c-stable
    libnotify
    gpick
    nodejs
    xorg.xcursorgen
    # httpie
    # httpie-oauth2-client-credentials
    deno
    mate.engrampa
    haiku-hand
    lxappearance
  ];

  programs.password-store = {
    enable = true;
  };

  programs.thunderbird = {
    enable = true;
    profiles.auri = {
      isDefault = true;
    };
  };

  accounts.email.accounts = {
    auri = {
      primary = true;
      address = "alessio@aurecchia.ch";
      thunderbird.enable = true;
      realName = "Alessio Aurecchia";
    };
    valora = {
      address = "alessio.aurecchia@valora.com";
      thunderbird.enable = true;
      realName = "Alessio Aurecchia";
    };
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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = ""; #"file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "HaikuHand";
    size = 32;
    package = haiku-hand;
  };

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
