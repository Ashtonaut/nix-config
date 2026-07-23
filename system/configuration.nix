{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./networking.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "claude-code" ];

  environment = {
    systemPackages = with pkgs; [
      inputs.agenix.packages.${stdenv.hostPlatform.system}.default
      git
      vim
    ];
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
  };

  programs.hyprland.enable = true;

  services = {
    xserver.xkb.layout = "gb";
    upower.enable = true;
    tlp.enable = true;
    thermald.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  security = {
    pam.services.hyprlock = { };
    rtkit.enable = true;
  };

  users = {
    mutableUsers = false;
    users.ashtonaut = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.age.secrets."ashtonaut.hash".path;
    };
  };

  age = {
    secrets."ashtonaut.hash".file = ../secrets/ashtonaut.hash.age;
    identityPaths = [ "/etc/agenix/key.txt" ];
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/London";
  console.useXkbConfig = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  zramSwap.enable = true;

  system.stateVersion = "25.11";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
  };
}
