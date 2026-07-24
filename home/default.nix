{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./hyprland.nix
  ];

  home.packages = [
    pkgs.claude-code
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

    hyprlock = {
      enable = true;
      settings = {
        input-field = [ { monitor = ""; } ];
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

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
      ];
    };
  };

  home.stateVersion = "25.11";
}
