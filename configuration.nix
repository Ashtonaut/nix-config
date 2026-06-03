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
    initialPassword = "changeme";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  time.timeZone = "Europe/London";

  networking = {
    hostName = "ashtonaut-laptop";
    networkmanager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.stateVersion = "25.11";
}
