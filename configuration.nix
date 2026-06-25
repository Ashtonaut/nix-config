{ 
  config, 
  pkgs,
  inputs, 
  ... 
}:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./disko-config.nix
  ];

  nixpkgs.config.allowUnfree = true; # In place for legacy, remove when possible!

  environment = {
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
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
  };

  specialisation.legacy.configuration = {
    system.nixos.tags = [ "legacy" ];
    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment.systemPackages = with pkgs; [
      vscode
      google-chrome
    ];
  };

  users.users.ashtonaut = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets."ashtonaut.hash".path;
  };

  age = {
    secrets = {
      "ashtonaut.hash".file = ./secrets/ashtonaut.hash.age;
      "eduroam.env".file = ./secrets/eduroam.env.age;
    };
    identityPaths = [ "/etc/agenix/key.txt" ];
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/London";
  console.useXkbConfig = true;

  networking = {
    hostName = "ashtonaut-laptop";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [ config.age.secrets."eduroam.env".path ];
        profiles.eduroam = {
          connection = {
            id = "eduroam";
            type = "wifi";
            autoconnect = true;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "eduroam";
          };
          wifi-security = {
            key-mgmt = "wpa-eap";
          };
          "802-1x" = {
            eap = "peap";
            phase2-auth = "mschapv2";
            anonymous-identity = "anonymous@leeds.ac.uk";
            identity = "$EDUROAM_IDENTITY";
            password = "$EDUROAM_PASSWORD";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
      };
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  swapDevices = [
    { 
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
