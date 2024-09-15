# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  pkgs-unstable,
  pkgs-dotnet,
  nix-colors,
  ...
}: 
let 
  haiku-hand = (pkgs.callPackage ./common/haiku-hand/haiku-hand.nix {});
  httpie-oauth2-client-credentials = (pkgs.callPackage ./common/httpie/httpie-oauth2-client-credentials.nix {
    buildPythonPackage = pkgs.python3Packages.buildPythonPackage;
  });
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
  home.file."scripts/switch_colors".source = ./scripts/switch_colors;

  home.file.".Xresources.light".source = ./common/wm/.Xresources.light;
  home.file.".Xresources.dark".source = ./common/wm/.Xresources.dark;
  xresources.extraConfig = ''
    #include ".Xresources.colors"
  '';

  home.packages = with pkgs; [
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
    source-code-pro
    ibm-plex
    inter
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    dconf
    xclip
    hsetroot
    feh
    typst
    pdftk
    xbanish
    xiccd
    gnumake
    findutils

    # Dev
    # (with pkgs-unstable.dotnetCorePackages; combinePackages [
    #   sdk_7_0_3xx
    #   sdk_8_0_1xx
    # ])
    (python3.withPackages (ps: with ps; [
      httpie
      httpie-oauth2-client-credentials
      oauthlib
    ]))
    terraform
    scrcpy
    elixir_1_16
    inotify-tools
    xsv
    pgcli

    nodePackages.vim-language-server
    difftastic

    bitwarden
    bitwarden-cli
    
    qmk
    via
    vial
    usbutils

    gimp-with-plugins
    inkscape
    simplescreenrecorder
    mate.mate-utils
    libreoffice-fresh
    pdfpc
    hledger
    hledger-ui
    hledger-web
    calibre
    transmission-gtk
    gparted

    chromium
    slack
    vlc
    mpv
    spotify
    zathura
    telegram-desktop
    discord
    libsForQt5.elisa

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
    xsettingsd
  ] ++ (with pkgs-unstable; [
    # nodePackages.pnpm
    corepack
    csvlens
  ]) ++ (with pkgs-dotnet; [
    (with dotnetCorePackages; combinePackages [
      sdk_8_0_3xx
      sdk_8_0_2xx
    ])
  ]);


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
  systemd.user = {
    startServices = "sd-switch";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
    BROWSER = "firefox";
    GTK_SCALE = "2";
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

  systemd.user.services.xsettingsd = {
    Unit = {
      Description = "xsettingsd";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      Environment = "PATH=${config.home.profileDirectory}/bin";
      ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd -c ${config.xdg.configHome}/xsettingsd";
      Restart = "on-abort";
    };
  };
  # services.xsettingsd = {
  #   enable = true;
  #   settings = {
  #     "Xft/Dpi" = 140;
  #   };
  # };

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  systemd.user.services.xiccd = {
    Unit = {
      Description = "Xiccd Screen Color Profiler";
    };
    Install = {
      WantedBy = [ "dbus.service" ];
      After = [ "dbus.service" ];
      PartOf = [ "dbus.service" ];
    };
    Service = {
      ExecStart = "${pkgs.xiccd}/bin/xiccd";
      ExecStop = "pkill xiccd";
      Restart = "always";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
