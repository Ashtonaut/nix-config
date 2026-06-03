{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  users.users.ashtonaut = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = "/etc/secrets/ashtonaut.hash";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  time.timeZone = "Europe/London";

  networking = {
    hostName = "ashtonaut-laptop";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [ "/etc/secrets/eduroam.env" ];
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

  system.stateVersion = "25.11";
}
