{ inputs, outputs, config, pkgs, ... }:

{
  imports =
    [ inputs.hardware.nixosModules.common-cpu-amd
      inputs.hardware.nixosModules.common-gpu-amd
      inputs.hardware.nixosModules.common-pc-ssd
      
      ./hardware-configuration.nix

      ./gui.nix
      ./pipewire.nix
	
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    hostName = "valus";

    networkmanager.enable = true;
  };

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

  programs.zsh.enable = true;

  users.users.auri = {
    isNormalUser = true;
    description = "Alessio Aurecchia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];	
	
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    arandr
  ];

  programs.thunar.enable = true;

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; vars = { hostName = config.networking.hostName; }; };
    users.auri = import ../../home/${config.networking.hostName}.nix;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
