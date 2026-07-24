{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./desktop
  ];

  home.packages = [
    pkgs.claude-code
    pkgs.brightnessctl
  ];

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Ashtonaut";
          email = "jzqq6560@leeds.ac.uk";
        };
      };
    };

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = {
        DontCheckDefaultBrowser = true;
      };
    };

    kitty.enable = true;
    vim.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = null;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.stateVersion = "25.11";
}
