{
  pkgs,
}:

{
  services = {
    upower.enable = true;
    tlp.enable = true;
    thermald.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.extraPackages = [ pkgs.intel-media-driver ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  zramSwap.enable = true;
}
