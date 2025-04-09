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

  home.file."scripts/switch_colors".source = ./scripts/switch_colors;
  home.file."scripts/notes".source = ./scripts/notes;

  home.packages = with pkgs; [
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    jetbrains-mono
    source-code-pro
    ibm-plex
    inter
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ia-writer-duospace
    iosevka
    mona-sans
    work-sans

    dmidecode
    dconf
    xclip
    hsetroot
    feh
    pdftk
    xbanish
    xiccd
    gnumake
    findutils
    emojipick

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
    hub

    nodePackages.vim-language-server
    difftastic

    bitwarden
    bitwarden-cli
    
    qmk
    via
    vial
    usbutils
    ltunify

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
    transmission_4-gtk
    gparted
    kicad
    openscad
    todoist-electron
    todoist

    chromium
    slack
    vlc
    mpv
    spotify
    zathura
    telegram-desktop
    discord
    libsForQt5.elisa
    freecad
    feh
    qimgv
    sqlite
    obs-studio
    parsec-bin

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
    typst
    prusa-slicer
  ]) ++ (with pkgs-dotnet; [
    (with dotnetCorePackages; combinePackages [
      sdk_9_0_1xx
    ])
  ]);


  programs.password-store = {
    enable = true;
  };

  programs.thunderbird = {
    enable = true;
    profiles.auri.isDefault = true;
  };

  accounts.email.accounts = {
    auri = {
      primary = true;
      address = "alessio@aurecchia.ch";
      realName = "Alessio Aurecchia";
      userName = "alessio.aurecchia@posteo.net";
      passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password posteo.net";
      imap = {
        host = "posteo.de";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "posteo.de";
        port = 465;
        tls.enable = true;
      };

      thunderbird.enable = true;
    };
    valora = {
      address = "alessio.aurecchia@valora.com";
      realName = "Alessio Aurecchia";
      userName = "alessio.aurecchia@valora.com";
      passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password 7be8c9bd-e09b-40c2-b60d-ac6700791bfe";
      flavor = "outlook.office365.com";

      # thunderbird = {
      #   enable = true;
        # settins = id: {
        #   "mail.smtpserver.smtp_${id}.authMethod" = 10;
        # };
      # };
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
