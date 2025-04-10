{ inputs, config, pkgs, ... }:

{
  imports =
    [ inputs.hardware.nixosModules.common-cpu-amd
      inputs.hardware.nixosModules.common-gpu-amd
      inputs.hardware.nixosModules.common-pc-ssd

      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hydrus";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "de_CH.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  users.users.auri = {
    isNormalUser = true;
    description = "Alessio Aurecchia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    killall
    htop
    git
    vim
    file
    python3
    unzip
    wget
    curl
  ];

  environment.localBinInPath = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "hydrus";
    database.createLocally = true;

    config = {
      adminuser = "admin";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };

  systemd.services.nextcloud-setup.serviceConfig = {
    RequiresMountsFor = [ "/var/lib/nextcloud" ];
  };

  services.nginx = {
    enable = true;
    virtualHosts."hydrus" = {
      forceSSL = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 433 ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
